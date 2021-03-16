install! 'cocoapods', :deterministic_uuids => false, :warn_for_multiple_pod_sources => false, :disable_input_output_paths => true

source 'git@git.xiaojukeji.com:ios/cocoapods-specs.git'

platform :ios, '9.0'
inhibit_all_warnings!

load "OnePods.rb"
enable_one_pods_libraries()
add_source_hook(true)
enable_one_cover_pods(true)
preprocess_one_dependency()

pod_one 'GlobalBFFService', :path => 'GlobalBFFService/GlobalBFFService.podspec', :inhibit_warnings => false

target 'Driver_Register' do
  pod 'JSONModel'
  pod 'Masonry'
  pod 'AFNetworking'
end