#
#  Copyright 2012 Christian Giacomi http://www.christiangiacomi.com
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

require 'spec_helper'

module R2do

  describe Category do
  
    before :each do
      @category = Category.new("A category")    
    end
  
    describe "#new" do
      context "with a description" do
        it "returns a Category object" do
          @category.should be_an_instance_of Category
        end

        it "contains no tasks" do
          @category.should have(0).tasks
        end
      end
    
      context "without a description" do
        it "raises an error" do
          expect{ Category.new }.to raise_error(ArgumentError)
        end
      end
    end

    describe "#add" do
      context "a nil task" do
        it "raises and error" do
          expect{ @category.add(nil) }.to raise_error(ArgumentError)
        end
      end

      context "in empty category" do
        it "has one task" do
          task = double("task")
          @category.add(task)
          @category.should have(1).tasks
        end
      end

      context "in a category with one task" do 
        it "has two tasks" do
          @category.add(double("task 1"))
          @category.should have(1).tasks

          @category.add(double("task 2"))
          @category.should have(2).tasks
        end
      end
    end
    
    describe "#remove" do
      context "in empty category" do
        it "raises an error" do
          expect{ @category.remove(Task.new("Sample Task")) }.to raise_error(TaskNotFoundError)        
        end
      end 
      
      context "on a category that doesn't contain the task" do
        it "raises an error" do
          @category.add(Task.new("My Task"))
          expect{ @category.remove(Task.new("Task to remove")) }.to raise_error(TaskNotFoundError)        
        end
      end  
      
      context "on the correct category" do
        it "returns the task" do
          task = Task.new("My Task")
          @category.add(task)
          removed_task = @category.remove(task)
          removed_task.should eql task
        end
        
        it "has a task less" do
          task = Task.new("My Task")
          @category.add(task)
          @category.should have(1).tasks
          
          removed_task = @category.remove(task)
          @category.should have(0).tasks          
        end
      end       
    end

    describe "#to_s" do
      context "with one task" do
        it "returns a description of the task" do
          result = "1. %-30s [ ] \n" % ["Sample task"]

          @category.add(Task.new("Sample task"))
          @category.to_s.should eql result 
        end
      end

      context "with two tasks" do
        it "returns the correct description of the tasks" do
          result = "1. %-30s [ ] \n2. %-30s [ ] \n" % ["First task", "Second task"]

          @category.add(Task.new("First task"))
          @category.add(Task.new("Second task"))
          @category.to_s.should eql result 
        end
      end
    end

  end

end