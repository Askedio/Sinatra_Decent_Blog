class String

    def striptags(trim = false)
        Striptags.convert(self, trim)
    end

    def striptags_trim
        striptags(true)
    end

end