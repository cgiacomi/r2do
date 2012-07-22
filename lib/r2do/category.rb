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
    # @return [Task] the current task
    attr_accessor :current_task


    # Creates a new instance of a Category
    #
    # @param [String] name the name for this category
    def initialize(name)
      @name = name
      @tasks = Array.new
      @current_task = nil
    end

    def rename(name)
      @name = name
    end

    # Finds a task based on the description.
    #
    # @param [String] description the task description.
    # @return [Task] the task identified by description.
    def find_by_description(description)
      @tasks.find { |t| t.description == description }
    end

    # Adds the object into the specific Category.
    #
    # @param [Task] task the task to add.
    # @raise [ArgumentError] if task is nil.
    # @raise [Exceptions::TaskAlreadyExistsError] if task with same description is already present.
    # @return [void]
    def add(task)
      raise ArgumentError unless not task.nil?

      duplicate = @tasks.find { |t| t.description == task.description }
      raise TaskAlreadyExistsError unless duplicate.nil?

      @tasks.push(task)
    end

    # Sets a Task as the current one.
    #
    # @param [Task] category the category to be set as current.
    # @return [void]
    def set_current(task)
      @current_task = task
    end

    # Clears the current task
    #
    # @return [void]
    def clear_current_task()
      @current_task = nil
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

      result << "%s:\n\n" % [@name]
      result << "    %-30s     %s\n" % ["Task", "Completed"]
      result << "    " << "-"*51
      result << "\n"

      @tasks.each do | task |
        count += 1
        result << "    %s\n" % task
      end

      return result.string
    end
  end

end