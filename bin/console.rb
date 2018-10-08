#!/usr/bin/env ruby

#require 'opencv'

require "bundler/setup"
require "./config/environment"
require "irb"
require './lib/picture'
IRB.start

require "pry"
Pry.start

include OpenCV

# Load an image
img = IplImage.load('sample.jpg')

# Load the cascade for detecting faces
detector = CvHaarClassifierCascade::load('haarcascade_frontalface_alt.xml.gz')

# Detect faces and draw rectangles around them
detector.detect_objects(img) do |rect|
  img.rectangle!(rect.top_left, rect.bottom_right, color: CvColor::Red)
end

# Create a window and show the image
window = GUI::Window.new('Face Detection')
window.show(img)
GUI::wait_key
