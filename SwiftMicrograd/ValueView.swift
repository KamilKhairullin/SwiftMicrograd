import Foundation
import SwiftUI
import Micrograd

struct ValueView: View {
    
    var value: Value
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text("Data: \(value.data.toStringRounded(scale: 2))")
                Text("Gradient: \(value.gradient.toStringRounded(scale: 2))")
                OperationView(operation: value.label, isBold: false)
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .foregroundStyle(Color.black)
            .background(Color.white)
            OperationView(operation: value.operation, isBold: true)
        }
    }
}

#Preview {
    ValueView(value: Value(
        data: 1.0,
        gradient: 2.0,
        label: "x",
        operation: "",
        previous: .init())
    )
}
