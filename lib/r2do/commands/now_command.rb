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
    class NowCommand < Command

      def initialize(state)
        super('n', 'now', 'Displays the information for the current category.')

        @state = state
      end

      # Creates a new category or makes a category current in the state if a category with the
      # same name already exists
      #
      # @param [Array] args the arguments passed to the app by the user
      # @raise [ArgumentError] if the command does not contain a name for the category
      # @return [void]
      def execute(args)
        display_current_category(args)
      end

      # Shows the detailed information for the current category, including the tasks contained
      #
      # @param [Array] args the arguments passed to the app by the user
      # @return [void]
      def display_current_category(args)
        #TODO: need to refatctor the code to remove the duplication
        if not @state.current_category
          UI.status("No category is currently selected.")
        else
          UI.status(@state.current_category.to_s)
          UI.new_line()
        end
      end

      def help()
        help = <<-EOF
          This is the help for the now command.
        EOF
      end

    end

  end

end