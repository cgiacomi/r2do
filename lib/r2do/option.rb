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

    class Option < Command

      # Creates an instance of a Command
      #
      # @param [String] short the short option name for this command
      # @param [String] extended the full option name for this command
      # @param [String] argument the optional argument for commands that have arguments
      # @param [String] description the command's description
      # @param [callback] callback the callback method for this command
      def initialize(short, extended, description, callback)
        super(short, extended, description, nil)

        if callback.nil?
          raise ArgumentError
        end

        @callback = callback
      end

      # Executes the callback of this command
      #
      # @param [Array] args the collection of arguments
      # @return [void]
      def execute(args)
        @callback.call(args)
      end

    end

  end

end