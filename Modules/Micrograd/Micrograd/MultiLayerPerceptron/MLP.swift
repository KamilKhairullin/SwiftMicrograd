import Foundation

public class MLP {
    
    let layers: [Layer]
    
    public init(layersWithSize: [Int]) {
        var layers: [Layer] = []
        for i in 0..<layersWithSize.count {
            let layer = Layer(numberOfNeurons: layersWithSize[i], prevLayerOutputSize: i == 0 ? 2 : layers[i-1].neurons.count)
            layers.append(layer)
        }
        self.layers = layers
    }
    
    public func call(input: [Value]) -> [Value] {
        var x = input
        for layer in layers {
            x = layer.call(input: x)
        }
        return x
    }
    
    public func parameters() -> [Value] {
        return layers.flatMap { $0.parameters() }
    }
    
    public func zeroParameters() {
        self.parameters().forEach {
            $0.gradient = 0
        }
    }
}
