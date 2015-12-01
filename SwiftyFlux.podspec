Pod::Spec.new do |s|
  s.name = 'SwiftyFlux'
  s.version = '0.2.1-alpha'
  s.license = { :type => "MIT" }
  s.summary = 'Flux for Swift 2.0'
  s.homepage = 'https://github.com/AlexanderNey/SwiftyFlux'
  s.social_media_url = 'http://twitter.com/Ajax64'
  s.authors = { 'Alexander Ney' => 'alexander.ney@me.com' }
  s.source = { :git => 'https://github.com/AlexanderNey/SwiftyFlux.git', :tag => s.version}
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'

  s.dependency 'Futuristics', '0.2.1-alpha'

  s.source_files = 'Source/*.swift'
end
