import ObjectMapper

class BaseRepo {
    typealias T = Any
    
    func sync() -> Bool {
        return false
    }
    
    func getAll() -> [Any] {
        return []
    }
    
    func get(uuid: String) -> Any? {
        return nil
    }
    
    func create(item: Any) -> Bool {
        return false
    }
    
    func update(item: Any) -> Bool {
        return false
    }
    
    func delete(item: Any) -> Bool {
        return false
    }
    
    func delete(idList : [String], completionHandler : @escaping (Bool)->Void){
        
    }
    
    func checkReachability() -> ReachabilityStatus {
        guard let reach = Reachability.networkReachabilityForInternetConnection() else {
            return ReachabilityStatus.notReachable
        }
        return reach.currentReachabilityStatus
    }

}

