import Foundation

// MARK: - Load API Data from the Local JSON file instead of going to the Back-End
class FileUtil {
    func getAPIData(forResource: String, ofType: String, completion: @escaping(Data?,Error?) -> Void)  {
        
        let testBundle = Bundle(for: type(of: self))
        
        if let path = testBundle.path(forResource: forResource, ofType: ofType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                completion(data, nil)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                completion(nil,error)
            }
        } else {
            let error = NSError(domain: "FileUtil", code: 0, userInfo: [NSLocalizedDescriptionKey:"Invalid filename/path."])
            completion(nil,error)
        }
    }


    func getModelData(forResource: String, ofType: String, completion: @escaping(Data?,Error?) -> Void) {
        getAPIData(forResource: forResource, ofType: ofType, completion: completion)
    }
}

