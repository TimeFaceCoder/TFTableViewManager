Pod::Spec.new do |s|
  s.name         = "TFTableViewManager"
  s.version      = "1.0.0"
  s.summary      = "TableView 管理器"
  s.homepage     = "https://github.com/TimeFaceCoder/TFTableViewManager.git"
  s.license      = "Copyright (C) 2015 TimeFace, Inc.  All rights reserved."
  s.author             = { "Melvin" => "yangmin@timeface.cn" }
  s.social_media_url   = "http://www.timeface.cn"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/TimeFaceCoder/TFTableViewManager.git"}
  s.source_files  = "TFTableViewManager/TFTableViewManager/**/*.{h,m,c}"
  s.requires_arc = true
  s.dependency 'pop'
  s.dependency 'AsyncDisplayKit'
end
