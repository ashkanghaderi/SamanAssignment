#---------------------*definition*------------------------
def rx_swift
  pod 'RxSwift’
end

def rx_cocoa
  pod 'RxCocoa’
end

def test_pods
  pod 'RxTest'
  pod 'RxBlocking'
end
#——————————*SamanTest*————————————

target ‘SamanTest’ do
        use_frameworks!

  # Pods from definition
  rx_cocoa
  rx_swift

  # Pods

target 'SamanTestTests' do
    inherit! :search_paths
    # Pods for testing
test_pods
  end

  target 'SamanTestUITests' do
    # Pods for testing
test_pods
  end

end
#---------------------*Domain*------------------------

target 'Domain' do
        use_frameworks!

  # Pods 
  rx_swift

  #-------*Tests*----------
  target 'DomainTests' do
    inherit! :search_paths
    test_pods
  end

end
#——————————*NetworkPlatform*————————————

target 'NetworkPlatform' do
	use_frameworks!

  # Pods 
  rx_swift
  
  pod 'Alamofire', '~> 5.4'
  pod 'Resolver'
  pod 'KeychainAccess'


  #-------*Tests*----------
  target 'NetworkPlatformTests' do
    inherit! :search_paths
    test_pods
  end
end 



