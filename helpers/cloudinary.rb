require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'

if Cloudinary.config.api_key.blank?
  require_relative '../config/cloudinary'
end

if Cloudinary.config.api_key.blank?
  puts "Please configure your Cloudinary account in ./config/cloudinary"
  exit
end