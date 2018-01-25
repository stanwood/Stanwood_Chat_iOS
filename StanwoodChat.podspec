Pod::Spec.new do |s|
  s.name             = 'StanwoodChat'
  s.version          = '0.0.3'
  s.summary          = 'StanwoodChat is a UI component meant primarily to support our chatbots'
  s.description      = <<-DESC
A UI component meant primarily to support our chatbots.
                       DESC

  s.homepage         = 'https://github.com/stanwood/Stanwood_Chat_iOS'
  s.license          = { :type => 'Private', :file => 'LICENSE' }
  s.author           = { 'Maciek Czarnik' => 'maciek.czarnik@stanwood.io' }
  s.source           = { :git => 'https://github.com/stanwood/Stanwood_Chat_iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  
  s.source_files = 'Sources/**/*.swift'
  s.resources =  ['Resources/Storyboards/*.storyboard']
end
