# Loading string extensions
require File.dirname(__FILE__) + '/striptags_string'

class Striptags

    def self.convert (str, trim = false)
        str.gsub(/<\/?[^>]*>/, "")
      #  str.gsub(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/, "")
      #  str.gsub(/<\s*\/?("a|strong|em")\s*[^>]*?>/, "")
    end

end
