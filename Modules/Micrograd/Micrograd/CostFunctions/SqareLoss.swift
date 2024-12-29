import Foundation


final public class SquareLoss {
    
    public static func calculate_loss(y_pred: [Value], y_val: [Value]) -> Value {
        var squareLoss = Value(data: 0)
        assert(y_pred.count == y_val.count, "y_pred and y_val count are not equal")
        
        for i in 0..<y_pred.count {
            let yout = y_pred[i]
            let ygt = y_val[i]
            let sub = yout - ygt
            let sqloss_i = sub ^^ 2
            squareLoss = squareLoss + sqloss_i
        }
        return squareLoss
    }
}
