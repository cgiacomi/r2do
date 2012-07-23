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
  module Commands

    describe Option do
      before(:each) do
        @callback_invoked = false
      end

      def callback(args)
        @callback_invoked = true
      end

      describe "#new" do
        context "valid arguments" do
          it "returns an instance of Option" do
            command = Option.new('c', 'category', 'description for this command', method(:callback))
            command.should be_an_instance_of Option
          end
        end

        context "null args" do
          it "raises an error if the swtich is null" do
            expect{ Option.new(nil, 'category', 'description for this command', method(:callback)) }.to raise_error(ArgumentError)
          end

          it "raises an error if the name is null" do
            expect{ Option.new('c', nil, 'description for this command', method(:callback)) }.to raise_error(ArgumentError)
          end

          it "raises an error if the description is null" do
            expect{ Option.new('c', 'category', nil, method(:callback)) }.to raise_error(ArgumentError)
          end

          it "raises an error if the callback is null" do
            expect{ Option.new('c', 'category', 'desctiption', nil) }.to raise_error(ArgumentError)
          end
        end
      end

      describe "#to_s" do
        it "returns the correct representation" do
          short = 'c'
          extended = 'category'
          description = 'description for this command'

          result = "%2s, %-10s \t# %s" % [short, extended, description]
          command = Option.new(short, extended, description, method(:callback))
          command.to_s.should eql result
        end
      end

      describe "#execute" do
        it "exectutes the callback" do
          @callback_invoked.should eql false

          short = 'c'
          extended = 'category'
          description = 'description for this command'
          args = Array.new
          command = Option.new(short, extended, description, method(:callback))
          command.execute(args)

          @callback_invoked.should eql true
        end
      end
    end
  end

end