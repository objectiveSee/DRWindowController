Pod::Spec.new do |s|
  s.name     = 'DRWindowController'
  s.version  = '1.0.2'
  s.platform = :ios
  s.ios.deployment_target = '5.0'
  s.license  = 'Creative Commons Attribution Non-Commercial License'
  s.summary  = 'An Objective-C / Cocoa Touch class for managing a vertical "stack" of UIViews and UIViewControllers.'
  s.homepage = 'https://github.com/objectiveSee/DRWindowController'
  s.author   = { "Danny Ricciotti" => "dan.ricciotti@gmail.com" }

  s.source   = { :git => 'https://github.com/objectiveSee/DRWindowController.git', :tag => "1.0.2"}
  s.source_files = 'DRWindows/DRWindows/DRWindows/DRWindowController*'
  s.requires_arc = true
end
