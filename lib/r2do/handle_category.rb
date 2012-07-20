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

  # Creates a new category or makes a category current in the state if a category with the
  # same name already exists
  #
  # @param [Array] args the arguments passed to the app by the user
  # @raise [ArgumentError] if the command does not contain a name for the category
  # @return [void]
  def handle_category(args)
    if args.length < 2
      raise ArgumentError, "The 'cat' command requires a name argument."
    end

    extra = ''
    category_name = args[1]
    if @state.contains?(category_name)
      cat = @state.get(category_name)
    else
      extra = 'new '
      cat = Category.new(category_name)
      @state.add(cat)
    end

    @state.set_current(cat)
    @modified = true

    UI.status("Switched to #{extra}category '#{category_name}'")
  end

end