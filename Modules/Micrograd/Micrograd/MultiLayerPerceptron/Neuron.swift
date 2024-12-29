import Foundation

class Neuron {
    var bias: Value
    var weights: [Value]
    
    convenience init(inputSize: Int) {
        self.init(
            weights: .init(repeating: Value.makeRandomValue(), count: inputSize),
            bias: Value.makeRandomValue()
        )
    }
    
    init(weights: [Value], bias: Value) {
        self.bias = bias
        self.weights = weights
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
