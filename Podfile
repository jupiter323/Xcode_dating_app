# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'Korte' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!

  # Pods for simple

#  pod "MXCardsSwipingView"
  pod "LSFloatingActionMenu"
  pod "MKDropdownMenu"
  pod "GoogleMaps"
  pod "GooglePlaces"
  pod "AffdexSDK-iOS"
  pod "Unirest", "~> 1.1.4"
#  pod "FBSDKLoginKit"

#  pod "DSCircularCollectionView"

# for chat
    pod 'MGCollapsingHeader'
#    pod 'NoChat', '~> 0.3'
#    pod 'YYText'
#    pod 'HPGrowingTextView'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if (target.name == "AWSCore") || (target.name == 'AWSKinesis')
            puts target.name
            target.build_configurations.each do |config|
                config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
            end
        end
    end
end
