require "rubygems"
require "bundler/setup"

Bundler.require(:default)
require "nano-cal"



class NanoCal < Thor
  
  desc "generate <nano_cal>", "generate an ical file from a nano-cal file"
  method_option :output, :aliases => "-o", :type => :string  
  method_option :verbose, :aliases => "-v", :type => :boolean, :default => false
  def generate(nano_cal)
    @nano_cal = nano_cal

    return @nano_cal.nil?
    
  end
 end

if __FILE__ == $0
  NanoCal.start
end
