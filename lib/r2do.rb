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

require 'optparse'
require 'ostruct'

require 'r2do/category'
require 'r2do/task'
require 'r2do/exceptions'
require 'r2do/command'
require 'r2do/version'


module R2do
  class App
    def initialize(args)
      @args = args
      @commands = create_commands()
    end
    
    def create_commands()
      cat_command = Command.new('cat', 'category', 'description', method(:create_category))
      version_command = Command.new('-v', '--version', 'Prints the application version', method(:show_version))
      help_command = Command.new('-h', '--help', 'You are looking at it.', method(:show_help))
            
      cmds = Hash.new
      cmds[cat_command.switch] = cat_command
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
        #print the help -h
        puts "should print the help"
      end      
    end
    
    def create_category(args)
      puts "Create a new category"
    end
    
    def show_help(args)
      puts "Show the help"
    end
    
    def show_version(args)
      puts R2do::VERSION
    end
    
  end

end