require_relative "models"

module NanoCal
  module Parser
    def Parser.file(file_path)
      json = open(file_path).read
      objs = JSON.load(json)
      
      events = []
      objs.each do |oEvent|
        events << Models::Event.new(oEvent)
      end
      events
    end
  end
end
