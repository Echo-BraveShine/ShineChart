
Pod::Spec.new do |s|


  s.name         = "ShineChart"
  s.version      = "1.0.2"
  s.summary      = "Swift 图表框架"
  s.description  = <<-DESC
      Swift4.0 轻量级图标框架,持续更新
                   DESC
  s.homepage     = "https://github.com/Echo-BraveShine/ShineChart"
  s.license      = "MIT"
  s.author             = { "BraceShine" => "1239383708@qq.com" }
  s.source       = { :git => "https://github.com/Echo-BraveShine/ShineChart.git", :tag => "v#{s.version}" }
  s.platform = :ios, "9.0"
  s.source_files  = "ShineChart/ShineChart/*.{swift}"
  s.framework  = "UIKit"
end
