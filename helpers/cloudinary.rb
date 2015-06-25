require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'

if Cloudinary.config.api_key.blank?
  require_relative '../config/cloudinary'
end