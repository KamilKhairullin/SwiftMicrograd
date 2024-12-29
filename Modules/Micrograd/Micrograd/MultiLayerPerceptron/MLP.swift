import Foundation

public class MLP {
    
    let layers: [Layer]
    
    public convenience init(layersWithSize: [Int]) {
        var layers: [Layer] = []
        for i in 0..<layersWithSize.count {
            let currentLayerNeuronsCount = layersWithSize[i]
            let layer = Layer(
                numberOfNeurons: currentLayerNeuronsCount,
                prevLayerOutputSize: i == 0 ? currentLayerNeuronsCount : layers[i-1].neurons.count
            )
            layers.append(layer)
        }
        self.init(layers: layers)
    }
    
    init(layers: [Layer]) {
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
