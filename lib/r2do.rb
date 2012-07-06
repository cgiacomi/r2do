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

<<<<<<< HEAD
=======
require 'yaml'

>>>>>>> 7abac2c655982a1a14e5032575fa9b230446f635
require 'r2do/category'
require 'r2do/task'
require 'r2do/exceptions'
require 'r2do/command'
require 'r2do/controller'
require 'r2do/version'


module R2do
  class App
    def initialize(args)
      @args = args
      @commands = create_commands()
      @controller = Controller.new()
    end

 
    def create_commands()
      cat_command = Command.new('cat', 'category', 'NAME', 'description', method(:create_category))
      cats_command = Command.new('cats', 'categories', nil, 'description', method(:show_categories))
      version_command = Command.new('-v', '--version', nil, 'Prints the application version', method(:show_version))
      help_command = Command.new('-h', '--help', nil, 'You are looking at it.', method(:show_help))
            
      cmds = Hash.new
      cmds[cat_command.switch] = cat_command
      cmds[cats_command.switch] = cats_command
      cmds[version_command.switch] = version_command 
      cmds[help_command.switch] = help_command 
      
      cmds    
    end

    
    def run()      
      option = @args[0]
      
      if @args.length > 0 and @commands.has_key?(option)
        cmd = @commands[option]
        cmd.execute(@args)
      else
        puts "r2do: '#{option}' is not an r2do command. See 'r2do -h'."
      end      
    end

    
    def create_category(args)
      if args.length < 2
        raise ArgumentError, "The 'Category' command requires a name argument."
      end 

      category_name = args[1]
      cat = Category.new(category_name)

      puts "Switched to #{category_name} category"
    end


    def show_categories(args)
      puts "todo: show all the available categories"
    end
    

    def show_help(args)
      puts "The most commonly used r2do commands are:"
      
      @commands.each do |key, value|
        puts "   %s" % value.to_s()
      end
    end
    

    def show_version(args)
      puts R2do::VERSION
    end
    
  end

end