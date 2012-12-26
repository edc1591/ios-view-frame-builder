Pod::Spec.new do |s|
  s.name         = "POViewFrameBuilder"
  s.version      = "1.0.1"
  s.summary      = "A small library for semantic layout of UIViews and NSViews."
  s.homepage     = "https://github.com/podio/ios-view-frame-builder"
  s.license      = 'MIT'
  s.author       = { "Sebastian Rehnby" => "sebastian@podio.com" }

  s.source       = { :git => "https://github.com/ishuo/ios-view-frame-builder.git", :tag => "1.0.1-mac" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6.8'
  
  s.source_files = 'POViewFrameBuilder/**/*.{h,m}'
  s.requires_arc = true
end
