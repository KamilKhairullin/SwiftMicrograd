import Foundation

extension Value {
    
    static func start_backpropagation(_ v: Value) {
        var topo: Array<Value> = .init()
        var visited: Set<Value> = .init()
        sortTopological(topo: &topo, visited: &visited, value: v)
        v.gradient = 1.0
        for item in topo.reversed() {
            item.backward()
        }
    }
    
    static func sortTopological(topo: inout [Value], visited: inout Set<Value>, value: Value) {
        if(!visited.contains(value)) {
            visited.insert(value)
            for v in value.previous {
                sortTopological(topo: &topo, visited: &visited, value: v)
            }
            topo.append(value)
        }
    }
}
