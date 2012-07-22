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

  class Task
    # @return [String] the description for this task.
    attr_accessor :description
    # @return [DateTime] the date and time of completion.
    attr_accessor :date_done
    # @return [DateTime] the date and time of creation
    attr_accessor :date_created

    # Creates a new instance of a Task
    #
    # @param [String] desctiption the description for this task
    def initialize(description)
      @description = description
      @done = false
      @date_created = DateTime.now
      @date_done = nil
    end

    # Renames this Task
    #
    # @param [String] description the new value for the task
    # @return [void]
    def rename(description)
      @description = description
    end

    # Gets the completed status of the specific task.
    #
    # @return [bool] true if the task is completed.
    def done?()
      return @done
    end

    # Flags the specific task as completed.
    #
    # @return [DateTime] the date and time of completion.
    def completed()
      @done = true
      @date_done = DateTime.now
    end

    # Returns a string representation of this Task
    #
    # @return [String] the representation of this Task
    def to_s()
      completed = ' '
      date = ''

      if done?
        completed = 'x'
        date = format_date(@date_done)
      end

      return "[%s] %-30s %s" % [completed, @description, date]
    end

    # Returns information regarding the state of this task.
    #
    # @return [String] the metadata for this task.
    def display()
      date = format_date(@date_created)

      result = StringIO.new

      result << "Selected task:\n"
      result << "   %s\n\n" % @description
      result << "Created:\n"
      result << "   %s" % date

      if done?
        result << "\nCompleted:\n"
        result << "   %s" % format_date(@date_done)
      end

      return result.string
    end

    # Formats the date
    #
    # @param [DateTime] date the date to parse
    # @return [String] the formatted date
    def format_date(date)
      date.strftime('%a %b %e, %Y')
    end
  end

end