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
  module_function

  # Shows the detailed information for the current category, including the tasks contained
  #
  # @param [Array] args the arguments passed to the app by the user
  # @return [void]
  def handle_current(args)
    if not @state.current_category
      UI.status("No category is currently selected.")
    else
      UI.status(@state.current_category.to_s)
      UI.new_line()
    end
  end

end