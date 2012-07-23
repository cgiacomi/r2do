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

      context "with a length of more than 30 characters" do
        it "raises and exception" do
          name = "a"*31
          expect { Task.new(name) }.to raise_error(ArgumentError)
        end
      end

      context "with a length of 30 chars" do
        it "returns a valid instance" do
          name = "a"*30
          Task.new(name)
        end
      end
    end

    describe "#description" do
      it "returns the correct description" do
        @task.description.should eql "Task to complete"
      end
    end

    describe "#to_s" do
      context "on a task that is not completed" do
        it "returns the correct to string representation" do
          result = "[ ] %-30s " % ["Task to complete"]
          @task.to_s.should eql result
        end
      end

      context "on a task that is complete" do
        it "returns the correct to string representation" do
          date = DateTime.now.strftime('%a %b %e, %Y')
          result = "[x] %-30s %s" % ["Task to complete", date]
          @task.completed()
          @task.to_s.should eql result
        end
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

        # it "cannot be modified" do
        #   @task.completed()
        #   expect { @task.date_done = DateTime.now }.to raise_error(NoMethodError)
        # end
      end
    end

  end

end