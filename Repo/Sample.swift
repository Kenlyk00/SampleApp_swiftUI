import UIKit
import RealmSwift
import Realm
import ObjectMapper

class Sample: Object, Mappable, BasicMapProtocol {
    var data: [Sample]?
    typealias T = Sample
    
    //Realm Object Methods
    required public init() {
        super.init()
    }
    
    required init(map: Map) {
        super.init()
        data <- map["data"]
        
    }
    
    @objc dynamic var uuid = UUID.init().uuidString
    @objc dynamic var jsonData = ""
    @objc dynamic var help = ""
    @objc dynamic var success = false
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    func mapping(map: Map) {
        if map.mappingType == .toJSON {
//            uuid                    >>> map["uuid"]
            jsonData                >>> map["data"]
            help                    >>> map["help"]
            success                 >>> (map["isDeleted"], BooleanFormatTransform())
        }
        else {
//            uuid                    <- map["uuid"]
            jsonData                <- map["data"]
            help                    <- map["help"]
            success                 <- (map["isDeleted"], BooleanFormatTransform())
        }
    }
    
}
