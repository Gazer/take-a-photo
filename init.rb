begin
  require 'RMagick'
rescue
  raise "RMagick is a required dependencie!"
end

require 'take_a_photo'
require 'take_a_photo/take_a_photo_helper'
require 'take_a_photo/request'

ActionView::Base.class_eval do
  include ActionView::Helpers::TakeAPhotoHelper
end