module NanoCal
  module Export
    module ClassMethods
      
    end
  
    module InstanceMethods
      def timezone=(timezone)
        RiCal::PropertyValue::DateTime.default_tzid = timezone
      end
      def export_ical
        cal = RiCal.Calendar do |cal|
            cal.default_tzid= 
          self.events.each do |nano_event|
            cal.event do
              summary nano_event.title if nano_event.title
              dtstart nano_event.start if nano_event.start            
              dtend nano_event.stop if nano_event.stop
              description nano_event.description if nano_event.description
            end
          end
        end
      end
    end
  
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods      
      #Set timezone to europe/copenhagen      
      RiCal::PropertyValue::DateTime.default_tzid = "Europe/Copenhagen"
    end
  end 
end
