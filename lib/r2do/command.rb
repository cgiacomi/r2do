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

class Command
  attr_reader :switch, :name, :description

  def initialize(switch, name, argument, description, callback)
    raise ArgumentError unless not switch.nil? and
                                not name.nil? and 
                                not description.nil? and
                                not callback.nil?
    
    @switch = switch
    @name = name
    @description = description
    @callback = callback
  end
    
  def execute(args)
    @callback.call(args)
  end


  def to_s()
    return "%-10s %s" % [@switch, @description]
  end
  
end