Pod::Spec.new do |s|
  s.name             = 'StanwoodChat'
  s.version          = '1.0.4'
  s.summary          = 'StanwoodChat is a UI component intended to support chatbot integrations'
  s.description      = <<-DESC
StanwoodChat is a UI component intended to support chatbot integrations.
                       DESC

  s.homepage         = 'https://github.com/stanwood/Stanwood_Chat_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'stanwood' => 'ios.frameworks@stanwood.io' }
  s.source           = { :git => 'https://github.com/stanwood/Stanwood_Chat_iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0' # maskedCorners is iOS 11...
  s.requires_arc = true

  s.source_files = 'Sources/**/*.swift'
  s.resources =  ['Resources/Storyboards/*.storyboard']
end
