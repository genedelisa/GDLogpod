Pod::Spec.new do |s|
 s.name = 'GDLog'

 s.version = '1.0.1'

 s.license = { :type => "MIT", :file => "LICENSE" }

 s.summary = 'Swift Logging based on OSLog'

 s.homepage = 'http://rockhoppertech.com'

 s.social_media_url = 'https://twitter.com/GeneDeLisaDev'

 s.authors = { "Gene De Lisa" => "GeneDeLisa@gmail.com" }

 s.source = { :git => "https://github.com/genedelisa/GDLog.git", :tag => s.version.to_s }

 s.platforms = { :ios => "11.0", :osx => "10.10", :tvos => "9.0", :watchos => "2.0" }

 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/**/*.swift"
     ss.framework  = "Foundation"
 end

#s.resources = 'Sources/**/*.{json}'
#s.resource_bundles = {
    #'GDLog' => [
        #'Sources/**/*.{xml,SF2,json}'
    #]
#}

s.pod_target_xcconfig =  {
    'SWIFT_VERSION' => '4.0',
}


end
