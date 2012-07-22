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
    class HelpCommand

      attr_accessor :short
      attr_accessor :extended
      attr_accessor :description
      attr_accessor :help

      YES = "Y"

      def initialize(cmd_list)
        @short = 'h'
        @extended = 'help'
        @description = 'Shows the help for a given command'
        @help = "TODO: help"

        @cmd_list = cmd_list
      end

      # Initializes the applications and resets the datafile
      #
      # @param [Array] args the arguments passed to the app by the user
      # @return [void]
      def execute(args)
        argument = args[1]

        cmd = @cmd_list.find { |c| c.short == argument or c.extended == argument }
        raise InvalidCommandError, "Invalid command. See 'r2do -h'" unless not cmd.nil?

        UI.status(cmd.help)
      end

      # Returns a string representation of this Command
      #
      # @return [String] the representation of this Command
      def to_s()
        return "%2s, %-10s \t# %s" % [@short, @extended, @description]
      end

    end

  end

end