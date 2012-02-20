require "json"
require "nano-cal/models"
require "nano-cal/parser"
require "nano-cal/export"

module NanoCal
  class NanoCal
    attr_accessor :events  
    include Parser
    include Export
  end
end
