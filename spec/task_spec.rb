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
require_relative '../lib/task'

describe Task do
  before :each do
    @task = Task.new("Task to complete")    
  end
  
  describe "#new" do
    context "with a description" do
      it "returns a Task object" do
        @task.should be_an_instance_of Task
      end
    end
    
    context "without a description" do
      it "raises an error" do
        expect { Task.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#description" do
    it "returns the correct description" do
      @task.description.should eql "Task to complete"
    end
  end

  describe "#to_s" do
    it "returns the correct to string representation" do
      @task.to_s.should eql "<Task to complete>"
    end
  end
  
  describe "#done" do
    context "by default" do
      it "returns false" do
        @task.done?.should eql false
      end
    end

    context "when a task is completed" do
      it "returns true" do
        @task.completed()
        @task.done?.should eql true
      end
    end
  end
  
  describe "#date_done" do
    context "when a task is not completed" do
      it "returns nil" do
        @task.date_done().should eql nil
      end
    end

    context "when a task is completed" do
      it "returns the correct date" do
        @task.completed()
        @task.date_done().strftime("%F").should eql DateTime.now().strftime("%F")
      end

      it "cannot be modified" do
        @task.completed()
        lambda{@task.date_done = DateTime.now}.should raise_error(NoMethodError)     
      end
    end  
  end
  
end