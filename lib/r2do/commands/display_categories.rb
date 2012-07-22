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
    class DisplayCategoriesCommand

      attr_accessor :short
      attr_accessor :extended
      attr_accessor :description
      attr_accessor :help

      def initialize(state)
        @short = 'd'
        @extended = 'display'
        @description = 'Displays all the categories.'
        @help = "TODO: help"

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

      # Returns a string representation of this Command
      #
      # @return [String] the representation of this Command
      def to_s()
        return "%2s, %-10s \t# %s" % [@short, @extended, @description]
      end
    end

  #   class HelpCommand

  #     attr_accessor :short
  #     attr_accessor :extended
  #     attr_accessor :description
  #     attr_accessor :help


  #     def initialize(@state)

  #     # Displays the help for a command
  #     #
  #     # @param [Array] args the arguments passed to the app by the user
  #     # @return [void]
  #     def handle_help(args)
  #       if args.length < 2
  #         show_help(args)
  #         return
  #       end

  #       command = args[1]
  #       UI.status("TODO: show the help for command '%s'" % command)
  #     end
  #   end



  end

end