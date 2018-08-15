Pod::Spec.new do |s|
  s.name         = "TFTableViewManager"
  s.version      = "1.1.0"
  s.summary      = "TableView 管理器"
  s.homepage     = "https://github.com/TimeFaceCoder/TFTableViewManager"
  s.license      = "Copyright (C) 2015 TimeFace, Inc.  All rights reserved."
  s.author             = { "Melvin" => "yangmin@timeface.cn" }
  s.social_media_url   = "http://www.timeface.cn"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/TimeFaceCoder/TFTableViewManager.git"}
  s.source_files  = "TFTableViewManager/**/*.{h,m,c}"
  s.requires_arc = true
  s.dependency 'Texture'
  s.library = 'c++'
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++'
   }
end
