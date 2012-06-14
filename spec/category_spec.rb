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
require_relative '../lib/category'

describe Category do
  
  before :each do
    @category = Category.new("A category")    
  end
  
  describe "#new" do
    context "with a description" do
      it "returns a Category object" do
        @category.should be_an_instance_of Category
      end
    end
    
    context "without a description" do
      it "raises an error" do
        lambda{Category.new}.should raise_error(ArgumentError)
      end
    end
  end
end
