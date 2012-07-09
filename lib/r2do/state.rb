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

  class State
    # @return [Hash] the collection of categories created by the user.
  	attr_accessor :categories
    # @return [Category] the current category the user is working on.
    attr_accessor :current_category

    # Creates a new instance of the State
    #
    def initialize()
      @categories = Hash.new
      @current_category = nil
    end

    # Sets a Category as the current one.
    #
    # @param [Category] category the category to be set as current.
    # @return [void]
    def set_current(category)
      @current_category = category
    end

    # Checks if a category with a specific name already exists.
    #
    # @param [String] category_name the name of the category to check.
    # @return [bool] true if the category is already present.
    def contains?(category_name)
      @categories.has_key?(category_name)
    end

    # Retrieves a specific Category.
    #
    # @param [String] category_name the name of the category to retrieve.
    # @return [Category] the category identified by category_name.
    def get(category_name)
      @categories[category_name]
    end

    # Adds a category.
    #
    # @param [Category] category the category to add.
    # @return [void]
    def add(category)
      @categories[category.name] = category
    end

  end

end