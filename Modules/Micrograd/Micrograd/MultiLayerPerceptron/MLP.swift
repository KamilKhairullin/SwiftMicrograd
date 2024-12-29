import Foundation

class MLP {
    
    let layers: [Layer]
    
    init(layersWithSize: [Int]) {
        var layers: [Layer] = []
        for i in 0..<layersWithSize.count {
            let layer = Layer(numberOfNeurons: layersWithSize[i], prevLayerOutputSize: i == 0 ? i : i - 1)
            layers.append(layer)
        }
        self.layers = layers
    }
    
    func call(input: [Value]) -> [Value] {
        var x = input
        for layer in layers {
            x = layer.call(input: x)
        }
        return x
    }
    
    func parameters() -> [Value] {
        return layers.flatMap { $0.parameters() }
    }
}
