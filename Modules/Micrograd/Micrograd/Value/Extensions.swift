import Foundation

public extension Double {
    
    func toStringRounded(scale: Int) -> String {
        return String(format: "%.\(scale)f", self)
    }
}
