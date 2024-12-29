import Foundation
import SwiftUI

struct OperationView: View {
    
    var operation: String?
    var isBold: Bool
    
    var body: some View {
        if let operationUnwrapped = operation, !operationUnwrapped.isEmpty {
            Text("\(operationUnwrapped)")
                .padding(EdgeInsets(top: isBold ? 18 : 1, leading: isBold ? 4 : 1, bottom: isBold ? 18 : 1, trailing: isBold ? 8 : 1))
                .border(Color.red, width: 2)
                .foregroundStyle(Color.black)
                .background(Color.white)
                .font(.system(size: isBold ? 16 : 8))
        } else {
            EmptyView()
        }
    }
}
