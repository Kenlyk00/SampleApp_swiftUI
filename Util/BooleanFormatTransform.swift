import Foundation
import ObjectMapper

public class BooleanFormatTransform: TransformType {
    public func transformToJSON(_ value: Bool?) -> String? {
        if value! {
            return "1"
        }
        return "0"
    }
    
    public typealias Object = Bool
    public typealias JSON = String
    
    public func transformFromJSON(_ value: Any?) -> Bool? {
        if let stringVal = value as? String {
            
            if stringVal == "1" || stringVal == "true"
            {
                return true
            }
        }
        
        if let intVal = value as? Int {
            if intVal == 1
            {
                return true
            }
        }
        return false
    }
}
