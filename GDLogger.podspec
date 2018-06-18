Pod::Spec.new do |s|
 s.name = 'GDLogger'
 s.version = '0.0.6'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'A facade for OSLog'
 s.homepage = 'http://rockhoppertech.com/blog'
 s.social_media_url = 'https://twitter.com/genedelisadev'
 s.authors = { "Gene De Lisa" => "gene@rockhoppertech.com" }
 s.source = { :git => "https://github.com/genedelisa/GDLogger.git", :tag => s.version.to_s }
 s.platforms = { :ios => "10.0", :osx => "10.10", :tvos => "10.0", :watchos => "3.0" }

 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/**/*.swift"
     ss.framework  = "Foundation"
 end

end
