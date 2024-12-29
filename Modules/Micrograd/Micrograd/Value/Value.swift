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
        label: String = "",
        operation: String? = nil,
        previous: Set<Value> = .init()
    ) {
        self.data = data
        self.gradient = gradient
        self.label = label
        self.operation = operation
        self.previous = previous
        self.id = UUID()
    }
}

extension Value: Hashable {
    public static func == (lhs: Value, rhs: Value) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
