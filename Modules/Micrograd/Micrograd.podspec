Pod::Spec.new do |spec|
  spec.name = "Micrograd"
  spec.version = "0.0.1"
  spec.summary = "Micrograd"
  spec.description = "Micrograd"
  spec.homepage = "homepage"

  spec.license = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author = { "Kamil Khairullin" => "k.khayrullin@innopolis.university" }
  spec.source = { :git => "local", :tag => "#{spec.version}" }

  spec.prefix_header_file = false
  spec.ios.deployment_target = '14.2'
  spec.macos.deployment_target = '14.2'

  spec.source_files = [
    'Micrograd/**/*.{swift,h,m}'
  ]

end
