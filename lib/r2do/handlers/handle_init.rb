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

    # Initializes the applications and resets the datafile
    #
    # @param [Array] args the arguments passed to the app by the user
    # @return [void]
    def handle_init(args)
      UI.status("Initialize new session?")
      UI.new_line()
      value = UI.input("Any previous session will be lost. Continue? [Yn]")
      if value == YES
        @state = State.new()
        @modified = true
        UI.status("Initialized a new session of r2do.")
      else
        UI.status("Continuing with current session.")
      end
    end

  end

end