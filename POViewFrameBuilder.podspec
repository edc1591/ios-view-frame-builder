Pod::Spec.new do |s|
  s.name         = "POViewFrameBuilder"
  s.version      = "1.0.2"
  s.summary      = "A small library for semantic layout of UIViews and NSViews."
  s.homepage     = "https://github.com/podio/ios-view-frame-builder"
  s.license      = 'MIT'
  s.author       = { "Sebastian Rehnby" => "sebastian@podio.com" }

  s.source       = { :git => "https://github.com/edc1591/ios-view-frame-builder.git", :head }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6.8'
  
  s.source_files = 'POViewFrameBuilder/**/*.{h,m}'
  s.requires_arc = true
end
