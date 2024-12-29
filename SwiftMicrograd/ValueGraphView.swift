import Foundation
import SwiftUI
import Micrograd

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct ValueGraphView: View {
    var value: Value
    @State private var positions: [Value: CGPoint] = [:]
    typealias Key = CollectDict<Value.ID, Anchor<CGPoint>>

    
    var body: some View {
            return ZStack(alignment: .center) {
                ValueView(value: value)
                    .anchorPreference(key: Key.self, value: .center, transform: {
                        [self.value.id: $0]
                    })
                    .padding(20)

                if (!value.previous.isEmpty) {
                    VStack(alignment: .center, spacing: 20) {
                        ForEach(Array(value.previous), id: \.id, content: { child in
                            ValueGraphView(value: child)
                        })
                    }
                    .padding(.leading, 300)
                }
            }
            .backgroundPreferenceValue(Key.self, { (centers: [Value.ID: Anchor<CGPoint>]) in
                GeometryReader { proxy in
                    ForEach(Array(value.previous), id: \.id, content: { child in
                        Line(
                            from: CGPoint(
                                x: proxy[centers[value.id]!].x + 60,
                                y: proxy[centers[value.id]!].y
                            ),
                            to: CGPoint(
                                x: proxy[centers[child.id]!].x,
                                y: proxy[centers[child.id]!].y
                            )
                        ).stroke()
                    })
                }
            })
        }
}


// Preview
#Preview {
    let a = Value(data: 2.0, label: "a")
    let b = Value(data: 3.0, label: "b")
    let c = a + b
    return ValueGraphView(value: c)
        .frame(width: 400, height: 400)
        .background(Color.gray.opacity(0.1))
}

