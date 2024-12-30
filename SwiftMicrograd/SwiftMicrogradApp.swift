import SwiftUI
import Micrograd

@main
struct SwiftMicrogradApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollView([.horizontal, .vertical]) {
                ValueGraphView(value: DataBuilder.loadModel())
            }
            OperationView(operation: "", isBold: false)
        }
    }
}
