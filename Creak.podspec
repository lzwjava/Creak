Pod::Spec.new do |s|
  s.name = 'Creak'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'Elegant HTML Parser in Swift'
  s.homepage = 'https://github.com/lzwjava/Creak'
  s.social_media_url = 'http://weibo.com/zhiweilee'
  s.authors = { 'lzwjava' => 'lzwjava@gmail.com' }
  s.source = { :git => 'https://github.com/lzwjava/Creak.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'
end
