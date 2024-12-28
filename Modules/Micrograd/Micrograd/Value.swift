import Foundation

struct Value {
    
    let data: Double
    let gradient: Double
    let label: String
    let previous: Set<Value>
    
    init(
        data: Double,
        gradient: Double,
        label: String,
        previous: Set<Value>
    ) {
        self.data = data
        self.gradient = gradient
        self.label = label
        self.previous = previous
    }
}

extension Value: Hashable {}
