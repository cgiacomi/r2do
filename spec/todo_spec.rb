#!/usr/bin/env ruby

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
require_relative '../lib/todo'

describe ToDo do
  before :each do
    @todo = ToDo.new("Task to complete")    
  end
  
  describe "#new" do
    context "with a description" do
        it "returns a ToDo object" do
            @todo.should be_an_instance_of ToDo
        end
    end
  end

  describe "#description" do
  	it "returns the correct description" do
      @todo.description.should eql "Task to complete"
    end
  end

  describe "#to_s" do
  	it "returns the correct to string representation" do
      @todo.to_s.should eql "<Task to complete>"
  	end
  end
  
  describe "#done" do
  	it "returns false by default" do
      @todo.done?.should eql false
  	end
  	
  	it "should return true if the todo is done" do
  	  @todo.completed()
  	  @todo.done?.should eql true
  	end
  end
  
  describe "#date_done" do
    it "should show the correct date of completion" do
  	  @todo.completed()
  	  @todo.date_done().strftime("%F").should eql DateTime.now().strftime("%F")
  	end
  	
  	it "should not be possible to change the date_done" do
  	  @todo.completed()
  	  lambda{@todo.date_done = DateTime.now}.should raise_error(NoMethodError)     
  	end
  end
  
end