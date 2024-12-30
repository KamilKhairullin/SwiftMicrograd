import Foundation

public final class Value: Identifiable {
    
    public var data: Double
    public var gradient: Double
    public var label: String = ""
    public var operation: String? = ""
    public var previous: Set<Value>
    public var backward: (() -> ()) = {}
    public let id: UUID
    
    public init(
        data: Double,
        gradient: Double = 0.0,
        label: String? = nil,
        operation: String? = nil,
        previous: Set<Value> = .init()
    ) {
        self.data = data
        self.gradient = gradient
//        self.label = ""label ?? data.toStringRounded(scale: 3)
//        self.operation = operation
        self.previous = previous
        self.id = UUID()
    }
}

extension Value: Hashable {
    public static func == (lhs: Value, rhs: Value) -> Bool {
        abs(lhs.data - rhs.data) < 1e-10 &&
        abs(lhs.gradient - rhs.gradient) < 1e-10 &&
        lhs.label == rhs.label &&
        lhs.operation == rhs.operation &&
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
//        hasher.combine(data)
//        hasher.combine(gradient)
//        hasher.combine(label)
//        hasher.combine(operation)
        hasher.combine(id)
    }
}

public extension Value {
    
    static func makeRandomValue() -> Value {
        return Value(data: Double.random(in: -1..<1))
    }
    
    static func makeRandomValueTrain() -> Value {
        return Value(data: Double.random(in: -0.5..<0.5).round(to: 4))
    }
    
    // 0.1 0.2 0.3 0.4 0.5
    var pretty: String {
        self.data.toStringRounded(scale: 4)
    }
    
    var prettyGrad: String {
        self.gradient.toStringRounded(scale: 2)
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
