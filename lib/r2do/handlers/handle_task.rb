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
  module Handlers
    module_function

    YES = "Y"

    #options
    COMPLETED = "--done"
    DISPLAY   = "--display"
    DELETE    = "--delete"
    EDIT      = "--edit"

    # Creates a new task or makes a task current in the current category if a task with the
    # same name already exists
    #
    # @param [Array] args the arguments passed to the app by the user
    # @raise [ArgumentError] if the command does not contain a name for the task
    # @return [void]
    def handle_task(args)
      if args.length < 2
        raise ArgumentError, "The 'task' command requires additional arguments."
      end

      if not @state.current_category
        raise CategoryNotSelectedError, "You need to select a category to create a new task."
      end

      option = args[1]

      if option.eql?(DISPLAY)
        require_selected_task()
        show_current_task(args)
      elsif option.eql?(EDIT)
        require_selected_task()
        edit_current_task(args)
      elsif option.eql?(COMPLETED)
        require_selected_task()
        mark_as_complete(args)
      elsif option.eql?(DELETE)
        require_selected_task()
        delete_task(args)
      elsif option.start_with?("--")
        raise InvalidOptionError, "Invalid argument for the command. See 'r2do -h'."
      else
        parse_task(args)
      end
    end

    # Edit the current task.
    #
    # @param [Array] args the arguments passed to the app by the user.
    # @return [void]
    def edit_current_task(args)
      UI.status("Are you sure you want to edit the task:")
      UI.status("   #{@state.current_category.current_task.description}")
      UI.new_line()
      value = UI.input("Continue? [Yn]")
      if value == YES
        desc = UI.input("Enter new description:")
        task = @state.current_category.current_task
        task.rename(desc)
        @modified = true

        UI.status("The task as been modified.")
      end
    end

    # Delete the currently selected task.
    #
    # @param [Array] args the arguments passed to the app by the user.
    # @return [void]
    def delete_task(args)
      UI.status("Are you sure you want to delete the task:")
      UI.status("   #{@state.current_category.current_task.description}")
      UI.new_line()
      value = UI.input("This action cannot be undone. Continue? [Yn]")
      if value == YES
        task = @state.current_category.current_task
        @state.current_category.remove(task)
        @state.current_category.clear_current_task()
        @modified = true

        UI.status("Task '#{task.description}' has been deleted.")
      end
    end

    # Displays the information of the currently selected task.
    #
    # @param [Array] args the arguments passed to the app by the user.
    # @return [void]
    def show_current_task(args)
      task = @state.current_category.current_task
      UI.status(task.display())
    end

    # Marks a task as completed.
    #
    # @param [Array] args the arguments passed to the app by the user.
    # @return [void]
    def mark_as_complete(args)
      task = @state.current_category.current_task
      task.completed()
      @modified = true

      UI.status("Task '%s' has been marked as completed." % task.description)
    end

    # Creates a new task or select an already existing one.
    #
    # @param [Array] args the arguments passed to the app by the user.
    # @return [void]
    def parse_task(args)
      extra = ''
      task_description = args[1]
      task = @state.current_category.find_by_description(task_description)
      if task.nil?
        task = Task.new(task_description)
        @state.current_category.add(task)

        UI.status("Created new task.")
        UI.new_line()
      end

      @state.current_category.set_current(task)
      @modified = true

      UI.status("Selected task '#{task_description}'")
    end

    # Checks that a task is currently selected.
    #
    # @return [void]
    def require_selected_task()
      if not @state.current_category.current_task
        raise TaskNotSelectedError, "This action requires a selected task."
      end
    end

  end

end