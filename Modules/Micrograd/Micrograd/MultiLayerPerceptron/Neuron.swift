import Foundation

class Neuron {
    var bias: Value
    var weights: [Value]
    
    init(inputSize: Int) {
        self.bias = Value.makeRandomValue()
        self.weights = .init(repeating: Value.makeRandomValue(), count: inputSize)
    }
    
    func call(input: [Value]) -> Value {
        var sum = bias
        for i in 0..<weights.count {
            sum = sum + weights[i] * input[i]
        }
        return sum.tanh()
    }
    
    func parameters() -> [Value] {
        return weights + [bias]
    }
}
