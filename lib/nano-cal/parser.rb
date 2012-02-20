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
        self.events.sort!
      end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end

    def Parser.to_date(obj)
      if obj.class == String
        DateTime.parse(obj)
      elsif [DateTime, Time].include?(obj.class)
        obj
      end
    end
  end
end
