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

module R2do

  class Category
    # @return [String] the name of this category.
    attr_accessor :name
    # @return [Array] the tasks this category contains.
    attr_accessor :tasks
    
    # Creates a new instance of a Category
    #
    # @param [String] name the name for this category
    def initialize(name)
      @name = name
      @tasks = Array.new
    end
    
    # Adds the object into the specific Category.
    #
    # @param [Task] task the task to add.
    # @raise [ArgumentError] if task is nil.
    # @return [void]
    def add(task)
      raise ArgumentError unless not task.nil?
      @tasks.push(task)
    end
    
    # Removes the object from the specific Category.
    #
    # @param [Task] task the task to remove.
    # @raise [Exceptions::TaskNotFoundError] if task is not found.
    # @return [void]
    def remove(task)
      @tasks.delete(task) { raise TaskNotFoundError.new() }
    end
    
    # Returns a string representation of this Category
    #
    # @return [String] the representation of this Category
    def to_s()
      count = 0
      result = StringIO.new

      @tasks.each do | task |
        count += 1
        result << "#{count}. %s\n" % task
      end

      return result.string
    end
  end

end