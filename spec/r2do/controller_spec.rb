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

  describe State do

    before :each do
      @state = State.new()    
    end

    describe "#new" do
      context "default constructor" do
        it "returns a State object" do
          @state.should be_an_instance_of State
        end

        it "contains no Categories" do
          @state.should have(0).categories
        end

        it "has no selected category" do
          @state.current_category.should eql nil
        end
      end
    end

    describe "#add" do
      context "adding one category" do
        it "contains one category" do
          @state.add(Category.new("A sample category"))
          @state.should have(1).categories
        end
      end
    end

  end

end