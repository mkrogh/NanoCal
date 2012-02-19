module NanoCal
  module Models

    module Jsonable
      module ClassMethods
        def from_json(json)
          o_json = JSON.load(json)
          self.new(o_json)
        end
      end
  
      module InstanceMethods
        def to_json(*a)
          hash = {}      
          self.instance_variables.each do |var|
            var_key = var.to_s.sub("@","").to_sym #remove @ from
            hash[var_key] = self.instance_variable_get var unless self.instance_variable_get(var).nil?
          end
          hash.to_json(*a)
       end
      end
  
      def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.send :include, InstanceMethods
      end
    end

    class Event
      attr_accessor :title, :description, :start, :stop
      include Comparable
      include Jsonable

      # Create a new NanoCal Event
      # @param [Hash] opts options to create an event from 
      # @options opts [String] :title Event title
      # @options opts [Time] :start Event start time
      # @options opts [Time] :stop Event end time
      # @options opts [String] :description Event description
      def initialize(opts ={})
        @title = opts[:title] || opts["title"]
        @description = opts[:description] || opts["description"]
        @start = to_date opts[:start] || opts["start"] 
        @stop = to_date opts[:stop] || opts["stop"]
      end

      def to_s
        "#@title - #@start"
      end
      
      def <=>(other_event)
        result = self.title<=>(other_event.title)
        result = self.start<=>(other_event.start) if result == 0
        result = self.stop<=>(other_event.stop) if result == 0
      end
    
      private
      def to_date(obj)
        if obj.class == String
          DateTime.parse(obj)
        elsif [DateTime, Time].include?(obj.class)
          obj
        end
      end   
    end
  end
end
