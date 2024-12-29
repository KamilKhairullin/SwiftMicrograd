import Foundation
import Micrograd

class DataBuilder {
    
    static func buildData() -> Value {
        let x_train: [[Value]] = (0...Params.train_dataset_size).map { _ in
            [Value.makeRandomValue(), Value.makeRandomValue()]
        }
        
        let y_train: [Value] = x_train.map { x_i in
            x_i[0] + x_i[1]
        }
        
        let x_test = (0...Params.test_dataset_size).map { _ in
            [Value.makeRandomValue(), Value.makeRandomValue()]
        }
        
        let y_test: [Value] = x_test.map { x_i in
            x_i[0] + x_i[1]
        }
        
        let mlp = MLP(layersWithSize: Params.layers)
        
        for _ in 0..<Params.train_iterations {
            var y_predicted: [Value] = []
            for j in 0...Params.train_dataset_size {
                let prediction = mlp.call(input: x_train[j])[0]
                y_predicted.append(prediction)
            }
            mlp.zeroParameters()
            let loss = SquareLoss.calculate_loss(y_pred: y_predicted, y_val: y_train)
            print(loss.data)
            Value.start_backpropagation(loss)
            let parameters = mlp.parameters()
            for param in parameters {
                let sum = (-1) * Params.learningRate * param.gradient
                param.data += sum
            }
        }
        
        for i in 0..<Params.test_dataset_size {
            let prediction = mlp.call(input: x_test[i])
            let real_y = y_test[i]
            print("For input: \(x_test[i][0].pretty) + \(x_test[i][1].pretty) = \(real_y.pretty)")
            print("Predicted: \(prediction[0].pretty), loss: \(SquareLoss.calculate_loss(y_pred: prediction, y_val: [real_y]).pretty)")
        }
        
        return Value(data: 0)
    }
}

extension DataBuilder {
    
    enum Params {
        static let train_dataset_size: Int = 100
        static let test_dataset_size: Int = 5
        static let train_iterations: Int = 100
        static let layers: [Int] = [2, 4, 4, 1]
        static let learningRate: Double = 0.01
    }
}
