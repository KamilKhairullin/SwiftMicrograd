import Foundation


final public class SquareLoss {
    
    public static func calculate_loss(y_pred: [Value], y_val: [Value]) -> Value {
        var squareLoss = Value(data: 0)
        assert(y_pred.count == y_val.count, "y_pred and y_val count are not equal")
        
        for (yout, ygt) in zip(y_pred, y_val) {
            squareLoss = squareLoss + (yout - ygt) * (yout - ygt)
        }
        return squareLoss
    }
}
