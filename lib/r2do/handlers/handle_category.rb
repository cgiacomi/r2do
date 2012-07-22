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

    # Creates a new category or makes a category current in the state if a category with the
    # same name already exists
    #
    # @param [Array] args the arguments passed to the app by the user
    # @raise [ArgumentError] if the command does not contain a name for the category
    # @return [void]
    def handle_category(args)
      if args.length < 2
        raise ArgumentError, "The 'category' command requires additional arguments."
      end

      option = args[1]

      if option.eql?(DISPLAY)
        display_current_category(args)
      elsif option.eql?(DELETE)
        require_selected_category()
        delete_category(args)
      elsif option.start_with?("--")
        raise InvalidOptionError
      else
        parse_category(args)
      end
    end

    # Shows the detailed information for the current category, including the tasks contained
    #
    # @param [Array] args the arguments passed to the app by the user
    # @return [void]
    def display_current_category(args)
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
        @modified = true

        UI.status("Category '#{cat.name}' has been deleted.")
      end
    end


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
      @modified = true

      UI.status("Switched to #{extra}category '#{category_name}'")
    end


    def require_selected_category()
      if not @state.current_category
        raise CategoryNotSelectedError, "This action requires a selected category."
      end
    end

  end

end