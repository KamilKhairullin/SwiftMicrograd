import Foundation

public class Value: Identifiable {
    
    public var data: Double
    public var gradient: Double
    public var label: String
    public var operation: String?
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
        self.label = label ?? data.toStringRounded(scale: 3)
        self.operation = operation
        self.previous = previous
        self.id = UUID()
    }
}

extension Value: Hashable {
    public static func == (lhs: Value, rhs: Value) -> Bool {
        abs(lhs.data - rhs.data) < 1e-10 &&
        abs(lhs.gradient - rhs.gradient) < 1e-10 &&
        lhs.label == rhs.label &&
        lhs.operation == rhs.operation
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
        hasher.combine(gradient)
        hasher.combine(label)
        hasher.combine(operation)
    }
}

public extension Value {
    
    static func makeRandomValue() -> Value {
        return Value(data: Double.random(in: 0..<0.5))
    }
    
    var pretty: String {
        self.data.toStringRounded(scale: 4)
    }
    
    var prettyGrad: String {
        self.gradient.toStringRounded(scale: 2)
    }
}
