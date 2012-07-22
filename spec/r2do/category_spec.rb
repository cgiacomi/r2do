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
      context "with a name" do
        it "returns a Category object" do
          @category.should be_an_instance_of Category
        end

        it "contains no tasks" do
          @category.should have(0).tasks
        end

        it "contains the correct name" do
          @category.name.should eql "A category"
        end
      end

      context "without a name" do
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
          task = Task.new("task")
          @category.add(task)
          @category.should have(1).tasks
        end
      end

      context "in a category with one task" do
        it "has two tasks" do
          @category.add(Task.new("task 1"))
          @category.should have(1).tasks

          @category.add(Task.new("task 2"))
          @category.should have(2).tasks
        end
      end

      context "add duplicate task" do
        it "raises an exception" do
          description = "Sample task"

          @category.add(Task.new(description))
          expect{ @category.add(Task.new(description)) }.to raise_error(TaskAlreadyExistsError)
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
          result = StringIO.new

          result << "#{@category.name}:\n\n"
          result << "    %-30s     %s\n" % ["Task", "Completed"]
          result << "    " << "-"*51
          result << "\n"
          result << "    [ ] %-30s \n" % ["Sample task"]


          @category.add(Task.new("Sample task"))
          @category.to_s.should eql result.string
        end
      end

      context "with two tasks" do
        it "returns the correct description of the tasks" do
          result = StringIO.new

          result << "#{@category.name}:\n\n"
          result << "    %-30s     %s\n" % ["Task", "Completed"]
          result << "    " << "-"*51
          result << "\n"
          result << "    [ ] %-30s \n" % "First task"
          result << "    [ ] %-30s \n" % "Second task"

          @category.add(Task.new("First task"))
          @category.add(Task.new("Second task"))
          @category.to_s.should eql result.string
        end
      end
    end

    describe "#find_by_description" do
      context "with no tasks" do
        it "returns nil" do
          task = @category.find_by_description('Sample Task')
          task.should eql nil
        end
      end

      context "with tasks" do
        it "returns nil if you provide the wrong desctiption" do
          @category.add(Task.new("Sample task"))
          task = @category.find_by_description("A non existent task")
          task.should eql nil
        end

        it "returns the task if it exists" do
          description = "Sample task"
          a_task = Task.new(description)
          @category.add(a_task)
          return_task = @category.find_by_description(description)
          return_task.should eql a_task
        end

        it "returns the task if it exists and there are multiple tasks" do
          description1 = "Sample task1"
          description2 = "Sample task2"

          task1 = Task.new(description1)
          task2 = Task.new(description2)

          @category.add(task1)
          @category.add(task2)

          return_task = @category.find_by_description(description2)
          return_task.should eql task2
        end
      end
    end

    describe "#set_current" do
      it "returns the correct task" do
        task = Task.new("Sample Task")
        @category.set_current(task)
        @category.current_task.should eql task
      end
    end

    describe "#clear_current_task" do
      it "should return nil" do
        task = Task.new("Sample Task")
        @category.set_current(task)
        @category.current_task.should eql task

        @category.clear_current_task()
        @category.current_task.should eql nil
      end
    end
  end

end