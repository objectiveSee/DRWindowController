Pod::Spec.new do |s|
  s.name     = 'DRWindowController'
  s.version  = '1.0.0'
  s.platform = :ios
  s.ios.deployment_target = '5.0'
  s.license  = 'Creative Commons Attribution Non-Commercial License'
  s.summary  = 'An Objective-C / CocoaTouch class the creates the concept of multiple windows within an Application. This is useful because Cocoa Touch does not allow you to create multiple UIWindows.'
  s.homepage = 'https://github.com/objectiveSee/DRWindowController'
  s.author   = { "Danny Ricciotti" => "dan.ricciotti@gmail.com" }

  s.source   = { :git => 'https://github.com/objectiveSee/DRWindowController.git'}
  s.source_files = 'DRWindows/DRWindows/DRWindows/DRWindowController*'

  s.requires_arc = true
end
