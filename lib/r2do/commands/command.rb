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

  class Command
    # @return [String] the value for the command switch.
    attr_reader :short
    # @return [String] the name of this command.
    attr_reader :extended
    # @return [String] the description for the command.
    attr_reader :description
    # @return [String] the help for this command
    attr_accessor :help

    # Creates an instance of a Command
    #
    # @param [String] short the short option name for this command
    # @param [String] extended the full option name for this command
    # @param [String] argument the optional argument for commands that have arguments
    # @param [String] description the command's description
    # @param [String] help the help for this command
    def initialize(short, extended, description, help)
      if short.nil? or extended.nil? or description.nil?
        raise ArgumentError
      end

      @short = short
      @extended = extended
      @description = description
      @help = help
    end

    # Executes the callback of this command
    #
    # @param [Array] args the collection of arguments
    # @return [void]
    def execute(args)
      raise ScriptError, "Cannot call execute on an abstract command"
    end

    # Returns a string representation of this Command
    #
    # @return [String] the representation of this Command
    def to_s()
      return "%2s, %-10s \t# %s" % [@short, @extended, @description]
    end

  end

end