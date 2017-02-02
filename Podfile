# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!

use_frameworks!

#Target are important because of swift update 1.2 to 2.0, let them to this current versions.

target 'FinalWeatherBbl' do
pod 'Alamofire'
pod 'SwiftyJSON'
end

target 'FinalWeatherBblTests' do
pod 'Alamofire'
pod 'SwiftyJSON'
end

post_install do |installer|
    plist_buddy = "/usr/libexec/PlistBuddy"
    installer.pods_project.targets.each do |target|
        plist = "Pods/Target Support Files/#{target}/Info.plist"
        original_version = `#{plist_buddy} -c "Print CFBundleShortVersionString" "#{plist}"`.strip
        changed_version = original_version[/(\d+\.){1,2}(\d+)?/]
        unless original_version == changed_version
            puts "Fix version of Pod #{target}: #{original_version} => #{changed_version}"
            `#{plist_buddy} -c "Set CFBundleShortVersionString #{changed_version}" "Pods/Target Support Files/#{target}/Info.plist"`
        end
    end
end

xcodeproj 'FinalWeatherBbl', 'Debug - local'=>:debug, 'Debug - staging'=>:debug, 'Debug - PRODUCTION'=>:debug