import Foundation

class Layer {
    
    let neurons: [Neuron]
    
    init(numberOfNeurons: Int, prevLayerOutputSize: Int) {
        self.neurons = (0..<numberOfNeurons).map { _ in Neuron(inputSize: prevLayerOutputSize) }
    }
    
    func call(input: [Value]) -> [Value] {
        neurons.map { $0.call(input: input) }
    }
    
    func parameters() -> [Value] {
        neurons.flatMap { $0.parameters() }
    }
}
