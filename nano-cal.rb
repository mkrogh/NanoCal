require "rubygems"
require "bundler/setup"

Bundler.require(:default)
require "nano-cal"



class NanoCalThor < Thor
  
  desc "generate <nano_cal>", "generate an ical file from a nano-cal file"
  method_option :output, :aliases => "-o", :type => :string  
  method_option :verbose, :aliases => "-v", :type => :boolean, :default => false
  def generate(nano_cal)
    nCal = NanoCal::NanoCal.new
    nCal.parse_file(nano_cal)

    iCal = nCal.export_ical

    if options[:output]
      open(options[:output], 'w') {|f| f.write(iCal)}
    else
      puts iCal
    end
    
  end
 end

if __FILE__ == $0
  NanoCalThor.start
end
