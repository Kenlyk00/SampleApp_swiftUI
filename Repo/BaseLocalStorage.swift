import UIKit
import Realm
import RealmSwift

class BaseLocalStorage: NSObject {
    typealias T = Object
    
    func getType() -> Object.Type {
        return Object.self
    }
    
    func create(item : [Object]) -> Bool{
        return autoreleasepool {() -> Bool in
            var isCreated = false
            let realm = try! Realm()
            
            if !item.isEmpty
            {
                try! realm.write {
                    realm.add(item, update: .all)
                    isCreated = true
                }
            }
            
            return isCreated
        }
    }
    
    func update(item: [Object]) -> Bool{
        return autoreleasepool {() -> Bool in
            var isUpdated = false
            let realm = try! Realm()
            
            if !item.isEmpty
            {
                try! realm.write {
                    realm.add(item, update: .all)
                    isUpdated = true
                }
            }
            
            return isUpdated
        }
    }
    
    func delete(item : [String]){
        
    }
    
    func getByIds(uuids : [String]) -> [Object]{
        return autoreleasepool {
            () -> [Object] in
            let realm = try! Realm()
            return realm.objects(self.getType()).filter("uuid in %@ AND isDeleted = %@", uuids,false).toArray(ofType: self.getType())
        }
    }
}
