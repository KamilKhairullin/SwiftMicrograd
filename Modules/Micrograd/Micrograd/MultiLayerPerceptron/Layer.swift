import Foundation

final class Layer {
    
    public let neurons: [Neuron]
    
    convenience init(numberOfNeurons: Int, prevLayerOutputSize: Int) {
        self.init(neurons: (0..<numberOfNeurons).map { _ in Neuron(inputSize: prevLayerOutputSize) })
    }
    
    init(neurons: [Neuron]) {
        self.neurons = neurons
    }
    
    func call(input: [Value]) -> [Value] {
        return neurons.map { $0.call(input: input) }
    }
    
    func parameters() -> [Value] {
        neurons.flatMap { $0.parameters() }
    }
    
    public func setParameters(parameters: [Value]) {
        var slide = 0
        for neuron in neurons {
            let paramsCount = neuron.parameters().count
            let start = slide
            let end = start + paramsCount
            neuron.setParameters(parameters: Array(parameters[start..<end]))
            slide += paramsCount
        }
    }
}
