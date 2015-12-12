Pod::Spec.new do |s|
  s.name         = "ScreenCapture"
  s.version      = "0.1.0"
  s.summary      = "Easily capture the screen on OS X."
  s.homepage     = "https://github.com/nirix/swift-screencapture"
  s.license      = "MIT"
  s.author       = "Jack P."
  s.platform     = :osx, "10.9"
  s.source       = { :git => "https://github.com/nirix/swift-screencapture.git", :tag => "v0.1.0" }
  s.source_files = "ScreenCapture/*.swift"
end
