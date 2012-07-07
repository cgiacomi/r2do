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
    attr_accessor :description, :date_done
    
    # Creates a new instance of a Task
    #
    # @param [String] desctiption the description for this task
    def initialize(description)
      @description = description
      @done = false
      @date_done = nil
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
        date = @date_done.strftime('(%a %b %e, %Y)')
      end

      return "%-30s [%s] %s" % [@description, completed, date]
    end
  end

end