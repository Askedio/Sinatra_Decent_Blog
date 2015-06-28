Gem::Specification.new do |spec|
    spec.name = 'striptags'
    spec.author = 'William Bowman'
    spec.description = 'Adds a method striptags to the string class that removes <> tags.'
    spec.summary = 'Adds String#striptags method'

    spec.files = Dir.glob("lib/*.rb") + %w(README)

    spec.version = '0.0.1'
end