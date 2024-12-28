def local_pod(name, **kwargs)
    kwargs[:path] = "./Modules/#{name}"
    pod name, kwargs
end

target 'SwiftMicrograd' do
  use_frameworks!

  local_pod 'Micrograd'

  target 'SwiftMicrogradTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftMicrogradUITests' do
    # Pods for testing
  end

end
