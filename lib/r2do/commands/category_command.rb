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
  module Commands
    class CategoryCommand < Command

      YES = "Y"

      DISPLAY   = "--display"
      DELETE    = "--delete"
      EDIT      = "--edit"

      def initialize(state)
        super('c', 'category', 'Creates a new category.', "TODO: help")

        @state = state
      end

      # Creates a new category or makes a category current in the state if a category with the
      # same name already exists
      #
      # @param [Array] args the arguments passed to the app by the user
      # @raise [ArgumentError] if the command does not contain a name for the category
      # @return [void]
      def execute(args)
        if args.length < 2
          raise ArgumentError, "The 'category' command requires additional arguments."
        end

        option = args[1]

        if option.eql?(DISPLAY)
          display_current_category(args)
        elsif option.eql?(EDIT)
          require_selected_category()
          edit_current_category(args)
        elsif option.eql?(DELETE)
          require_selected_category()
          delete_category(args)
        elsif option.start_with?("--")
          raise InvalidOptionError
        else
          parse_category(args)
        end
      end

      # Edit the current task.
      #
      # @param [Array] args the arguments passed to the app by the user.
      # @return [void]
      def edit_current_category(args)
        UI.status("Are you sure you want to edit the category:")
        UI.status("   #{@state.current_category.name}")
        UI.new_line()
        value = UI.input("Continue? [Yn]")
        if value == YES
          name = UI.input("Enter new name:")
          cat = @state.current_category
          cat.rename(name)
          @state.modified = true

          UI.status("The category as been modified.")
        end
      end

      # Shows the detailed information for the current category, including the tasks contained
      #
      # @param [Array] args the arguments passed to the app by the user
      # @return [void]
      def display_current_category(args)
        #TODO: need to refatctor the code to remove the duplication (NowCommand)
        if not @state.current_category
          UI.status("No category is currently selected.")
        else
          UI.status(@state.current_category.to_s)
          UI.new_line()
        end
      end

      # Deletes the currently selected category
      #
      # @param [Array] args the argumets passed to the app by the user
      # @return [void]
      def delete_category(args)
        UI.status("Are you sure you want to delete the category:")
        UI.status("   #{@state.current_category.name}")
        UI.new_line()
        UI.status("All tasks contained in this category will be lost.")
        value = UI.input("This action cannot be undone. Continue? [Yn]")
        if value == YES
          cat = @state.current_category
          @state.remove(cat)
          @state.clear_current_category()
          @state.modified = true

          UI.status("Category '#{cat.name}' has been deleted.")
        end
      end

      # Creates a new Category or selects an already existing one.
      #
      # @param [Array] args the argumets passed to the app by the user.
      # @return [void]
      def parse_category(args)
        extra = ''
        category_name = args[1]
        if @state.contains?(category_name)
          cat = @state.get(category_name)
        else
          extra = 'new '
          cat = Category.new(category_name)
          @state.add(cat)
        end

        @state.set_current(cat)
        @state.modified = true

        UI.status("Switched to #{extra}category '#{category_name}'")
      end

      # Ensures that a category is selected.
      #
      # @return [void]
      def require_selected_category()
        if not @state.current_category
          raise CategoryNotSelectedError, "This action requires a selected category."
        end
      end

    end

  end

end