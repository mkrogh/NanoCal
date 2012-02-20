require_relative "models"

module NanoCal
  module Parser
    module ClassMethods
      
    end
  
    module InstanceMethods
      def parse_file(file_path)
        json = open(file_path).read
        objs = JSON.load(json)
        
        self.events = []
        objs.each do |oEvent|
          events << Models::Event.new(oEvent)
        end
        self.events
      end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
