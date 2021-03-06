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
    class DisplayCategoriesCommand < Command

      def initialize(state)
        super('l', 'list', 'Displays all the categories.')

        @state = state
      end

      # Displays all the categories available
      #
      # @param [Array] args the arguments passed to the app by the user
      # @return [void]
      def execute(args)
        if @state.categories.empty?
            UI.status("No categories to display")
        else
          @state.categories.each do |key, value|
            current = (value == @state.current_category && "*") || ' '
            UI.status("#{current} #{value.name}")
          end
        end
      end

      def help()
        help = <<-EOF
NAME
       r2do #{@extended}

SYNOPSIS
       'r2do #{@extended}' or 'r2do #{@short}' are equivalent

DESCRIPTION
      The #{@extended} lets you Lists all the available categories in the application.

      The current selected category is marked with and asterisk '*'

      usage: r2do #{@extended}

      e.g.

        Category 1
      * Category 2
        Category 3

        EOF
      end

    end

  end

end