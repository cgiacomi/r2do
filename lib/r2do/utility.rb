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

  module Utility
    module_function

    # Loads the data file and deserializes the State.
    #
    # @param [String] file_name the name of the file to load.
    # @return [State] the application State.
    def load_state(file_name)
      file_path = calculate_path(file_name)

      if File.exists?(file_path)
        file = File.open(file_path, "rb")
        state = YAML::load(file.read)
      else
        state = State.new
      end

      state
    end

    # Saves the data file and serializes the State.
    #
    # @param [String] file_name the name of the file to save.
    # @param [State] the application state to save.
    # @return [void]
    def save_state(file_name, state)
      file_path = calculate_path(file_name)

      file = File.new(file_path, 'w')
      file.write(YAML.dump(state))
      file.close()
    end

    # Calculates the path location for the data file.
    #
    # @param [String] file_name the name of the file to load.
    # @return [String] the full destination path including the filename.
    def calculate_path(file_name)
      data_path = File.expand_path("~/")
      file_path = File.join(data_path, file_name)
    end

    # Show the help command
    #
    # @param [Array] args the list of args the user passed the application
    # @return [void]
    def show_help(args)
      UI.status("Usage:")
      UI.status("    r2do <command> [<args>] [options]")
      UI.new_line()
      UI.status("Commands:")

      @commands.each do |value|
        UI.status("   %s" % value.to_s())
      end

      UI.new_line()
      UI.status("See 'r2do help <command>' for more information on a specific command.")
    end

    # Show the version number of the application
    #
    # @param [Array] args the list of args the user passed the application
    # @return [void]
    def show_version(args)
      UI.status(R2do::VERSION)
    end

  end

end