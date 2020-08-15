import UIKit
import RealmSwift
import Realm

class SampleLocalStorage : BaseLocalStorage {
    func create(item: Sample) -> Bool {
        return super.create(item: [item])
    }
    
    func update(item: Sample) -> Bool {
        return super.update(item: [item])
    }
    
    func delete(item:Sample) -> Bool {
        return deleteById(uuid: item.uuid)
    }
    
    func deleteAll() -> Void{
        self.getList().forEach { (item) in
            self.delete(item: item)
        }
    }
    
    func deleteById(uuid: String) -> Bool{
        var isDeleted = false
        let realm = try! Realm()
        
        if !uuid.isEmpty
        {
            let existingRecord = realm.objects(Sample.self).filter("uuid=%@", uuid).first!
            
            try! realm.write {
                realm.delete(existingRecord)
                isDeleted = true
            }
        }
        
        return isDeleted
    }
    
    func deleteByIdList(IdList: [String]) -> Bool
    {
        var isDeleted = true
        
        for id in IdList
        {
            if deleteById(uuid: id) == false
            {
                isDeleted = false
            }
        }
        
        return isDeleted
    }
    
    func getList() -> [Sample]
    {
       let realm = try! Realm()
       return realm.objects(Sample.self).toArray(ofType: Sample.self)
    }
    
    func getSampleBy(uuid : String) -> Sample? {
        let realm = try! Realm()
        return realm.objects(Sample.self).filter("uuid=%@",uuid).first
    }
}
