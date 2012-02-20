module NanoCal
  module Export
    module ClassMethods
      
    end
  
    module InstanceMethods
      def advance_to(start_date)
        start = Parser.to_date(start_date)
        first_date = self.events.first.start.to_date
        
        days = 0
        self.events.collect! do |event|
          days += 1 if first_date.advance(:days => (days+1)) < event.start

          ds = start.advance(:days => days)
          de = ds
          de = start.advance(:days => (days+1)) if event.start.to_date < event.stop.to_date

          event.start = DateTime.new(ds.year, ds.month, ds.day, event.start.hour, event.start.minute,event.start.second, event.start.zone) unless event.start.nil?
          event.stop = DateTime.new(de.year, de.month, de.day, event.stop.hour, event.stop.minute, event.stop.second, event.stop.zone) unless event.stop.nil?
          event
        end
      end
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
