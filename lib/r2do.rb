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

require 'yaml'

require 'r2do/ui'
require 'r2do/category'
require 'r2do/task'
require 'r2do/exceptions'
require 'r2do/command'
require 'r2do/state'
require 'r2do/version'
require 'r2do/handlers/handle_category'
require 'r2do/handlers/handle_task'
require 'r2do/handlers/handle_init'
require 'r2do/handlers/handle_categories'
require 'r2do/handlers/handle_current'
require 'r2do/utility'


module R2do
  class App
    include R2do
    include Utility
    include Handlers

    # Creates an instance of the application.
    #
    # @param [Array] args the command line args.
    def initialize(args)
      @args = args
      @commands = create_commands()
      @modified = false
      @file_name = ".r2do.yml"

      @state = load_state(@file_name)
    end

    # Evaluates the command passed by the user and calls the corresponding application command.
    #
    # @return [void]
    def run()
      option = @args[0]

      if @args.length > 0
        cmd = find_command(option)
        if not cmd.nil?
          cmd.execute(@args)
        else
          invalid_command(option)
        end
      else
        show_help(@args)
      end
    end

    # Saves the state of the application
    #
    # @return [void]
    def save()
      if @modified
        save_state(@file_name, @state)
      end
    end

    private

    # Creates the list of commands the application responds to.
    #
    # @return [Array] the collection of commands.
    def create_commands()
      cmd_list = Array.new
      cmd_list << Command.new('i', 'initialize', nil, 'Initializes a new clean session.', method(:handle_init))
      cmd_list << Command.new('c', 'category', 'NAME', 'Creates a new category', method(:handle_category))
      cmd_list << Command.new('t', 'task', 'NAME', 'Adds a new task to the current category.', method(:handle_task))
      cmd_list << Command.new('d', 'display', nil, 'Displays all the categories', method(:handle_categories))
      cmd_list << Command.new('n', 'now', nil, 'Displays the information for the current category', method(:display_current_category))
      cmd_list << Command.new('h', 'help', nil, 'Displays the help for a command', method(:handle_help))

      cmd_list << Command.new('-v', '--version', nil, 'Prints the application version.', method(:show_version))
      cmd_list << Command.new('-h', '--help', nil, 'You are looking at it.', method(:show_help))

      cmd_list
    end

    # Finds the command based on the option value passed by the user
    #
    # @param [String] option the option the user passed the application
    # @return [Command] the command identified by option, else nil
    def find_command(option)
      @commands.find { |cmd| cmd.short == option or cmd.extended == option }
    end

    # Invalid command handler
    #
    # @param [String] option the option the user passed the application
    # @return [void]
    def invalid_command(option)
      UI.status("r2do: '#{option}' is not an r2do command. See 'r2do -h'.")
    end

  end

end