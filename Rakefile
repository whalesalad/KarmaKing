# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'KarmaKing'
  app.version = '1.0'
  app.identifier = 'com.belluba.karmaking'
  app.interface_orientations = [:portrait, :portrait_upside_down]

  app.libs << '/usr/lib/libz.1.1.3.dylib'
  app.libs << '/usr/lib/libsqlite3.dylib'
  
  app.frameworks += [
    'AdSupport',
    'Accounts',
    'Social',
    'AudioToolbox',
    'CFNetwork',
    'CoreGraphics',
    'CoreLocation',
    'MobileCoreServices',
    'QuartzCore',
    'Security',
    'StoreKit',
    'SystemConfiguration']

  app.vendor_project('vendor/Parse.framework', :static, 
    :products => ['Parse'], 
    :headers_dir => 'Headers')

  app.vendor_project('vendor/FacebookSDK.framework', :static, 
    :products => ['FacebookSDK'], 
    :headers_dir => 'Headers')

end
