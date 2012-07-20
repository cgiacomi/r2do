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
  module_function

  COMPLETED = "-c"

  # Creates a new task or makes a task current in the current category if a task with the
  # same name already exists
  #
  # @param [Array] args the arguments passed to the app by the user
  # @raise [ArgumentError] if the command does not contain a name for the task
  # @return [void]
  def handle_task(args)
    if args.length < 2
      raise ArgumentError, "The 'task' command requires a name argument."
    end

    if not @state.current_category
      raise CategoryNotSelectedError, "You need to select a category to create a new task."
    end

    if args.include?(COMPLETED)
      mark_as_complete(args)
    end

    extra = ''
    task_description = args[1]
    task = @state.current_category.find_by_description(task_description)
    if task.nil?
      task = Task.new(task_description)
      @state.current_category.add(task)
      extra = 'new '
    end

    @state.current_category.set_current(task)
    @modified = true

    UI.status("Switched to #{extra}task '#{task_description}'")
  end


  def mark_as_complete(args)

  end

end