platform :ios, '13.0'

target 'simple-todo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for simple-todo
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'RxSwift'
  pod 'RxCocoa'

  target 'simple-todoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'simple-todoUITests' do
    # Pods for testing
  end
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
  end
 end
end
