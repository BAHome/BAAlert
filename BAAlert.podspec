#
# Be sure to run `pod lib lint BAAlert.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BAAlert'
    s.version      = "1.2.7"
    s.summary      = '目前为止，最为精简的 alert 和 actionSheet 封装！BAAlert 让你的弹框不再孤单！'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage     = 'https://github.com/BAHome/BAAlert'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'boai' => 'sunboyan@outlook.com' }
    s.source       = { :git => 'https://github.com/BAHome/BAAlert.git', :tag => s.version.to_s }

    s.resource_bundles = {
      'BAAlert' => ['BAAlert/Resources/*.{xcassets,bundle}',
      'BAAlert/**/*.{xib,nib,json,plist}']
    }

    s.source_files  = "BAAlert/**/*.{h,m}"
    s.public_header_files = 'BAAlert/Classes/**/*.h}'
    s.frameworks = 'UIKit', 'Foundation'

    s.ios.deployment_target = '8.0'
    s.requires_arc = true

end
