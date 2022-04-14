#
#  Be sure to run `pod spec lint EasingInterpolator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "EasingInterpolator"
  spec.version      = "0.0.1"
  spec.summary      = "Interpolation Library supporting 31 different easing functions"
  spec.homepage     = "https://github.com/odemiral/EasingInterpolator"
  spec.license      = { :type => "MIT", :file => 'LICENSE' }
  spec.author             = { "Onur Demiralay" => "onurd91@gmail.com" }
  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.15"
  spec.source       = { :git => "https://github.com/odemiral/EasingInterpolator.git", :tag => "#{spec.version}" }
  spec.source_files  = "EasingInterpolator/**"
  # spec.requires_arc = true
  spec.swift_version = "5"
end
