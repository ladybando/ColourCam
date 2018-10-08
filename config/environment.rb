require 'rb_webcam'
require 'RMagick'
require 'console.rb'

capture = Webcam.new

image = capture.grab
width = image.size[:width]
rows = image.data.unpack("C*").each_slice(3).to_a.each_slice(width).to_a
capture.close

height = rows.length
img = Magick::Image.new width, height

rows.each_with_index do |r, i|
q = r.map {|b, g, r| Magick::Pixel.new r * 256, g * 256, b * 256, 0}
img.store_pixels(0, i, width, 1, q)
end

img.format = 'jpg'
img.write 'webcam.jpg'
