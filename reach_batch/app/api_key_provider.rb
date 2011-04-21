class ApiKeyProvider
   def initialize(location = "resources/api_key.txt")
      @location = location
   end

   def api_key
      File.new(@location).read.chomp
   end
end
