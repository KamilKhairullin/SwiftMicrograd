import Foundation

struct Value {
    
    let data: Double
    let gradient: Double
    let label: String
    let operation: String
    let previous: Set<Value>
    
    init(
        data: Double,
        gradient: Double,
        label: String,
        operation: String,
        previous: Set<Value>
    ) {
        self.data = data
        self.gradient = gradient
        self.label = label
        self.operation = operation
        self.previous = previous
    }
}

extension Value: Hashable {}

infix operator +: AdditionPrecedence

extension Value {

    static func + (lhs: Value, rhs: Value) -> Value {
        return Value(
            data: lhs.data + rhs.data,
            gradient: 0.0,
            label: "\(lhs.label) + \(rhs.label)",
            operation: "+",
            previous: [lhs, rhs]
        )
    }
}
