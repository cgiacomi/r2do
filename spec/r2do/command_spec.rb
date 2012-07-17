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

  describe Command do

    def callback()
      #empty on purpose
    end

    describe "#new" do
      context "valid arguments" do
        it "returns an instance of Command" do
          command = Command.new('cat', 'category', nil, 'description for this command', method(:callback))
          command.should be_an_instance_of Command
        end
      end

      context "null args" do
        it "raises an error if the swtich is null" do
          expect{ Command.new(nil, 'category', nil, 'description for this command', method(:callback)) }.to raise_error(ArgumentError)
        end

        it "raises an error if the name is null" do
          expect{ Command.new('cat', nil, nil, 'description for this command', method(:callback)) }.to raise_error(ArgumentError)
        end

        it "raises an error if the description is null" do
          expect{ Command.new('cat', 'category', nil, nil, method(:callback)) }.to raise_error(ArgumentError)
        end

        it "raises an error if the callback is null" do
          expect{ Command.new('cat', 'category', nil, 'desctiption', nil) }.to raise_error(ArgumentError)
        end
      end
    end

  end

end