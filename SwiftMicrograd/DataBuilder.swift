import Foundation
import Micrograd

class DataBuilder {
    
    static func buildData() -> Value {
        let x1 = Value(data: 2.0, label: "x1")
        let x2 = Value(data: 0.0, label: "x2")

        let w1 = Value(data: -3.0, label: "w1")
        let w2 = Value(data: 1.0, label: "w2")

        let b = Value(data: 6.8813735870195432, label: "b")

        let x1w1 = x1 * w1
        let x2w2 = x2 * w2
        let x1w1x2w2 = x1w1 + x2w2
        let n = x1w1x2w2 + b
        
        let e = (2 * n).exponent()
        let o = (e - 1) / (e + 1)
        
        Value.start_backpropagation(o)
        
        
        return o
    }
}
