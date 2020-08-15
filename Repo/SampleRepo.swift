import Foundation
class SampleRepo: BaseRepo {
    typealias T = Any
    
    var sampleLocalStorage: SampleLocalStorage
    var sampleApiClient: SampleApiClient

    override init() {
        sampleApiClient = SampleApiClient()
        sampleLocalStorage = SampleLocalStorage()
    }
    
    func getAll(completionHandler: @escaping (Sample?, Error?) -> Void) {
        
        let existingRecords = sampleLocalStorage.getList().first
        
        if self.checkReachability() == .notReachable {
            if (existingRecords != nil) {
                completionHandler(existingRecords, nil)
            }
            else {
                self.mockSampleData { (result, error) in
                    completionHandler(result, error)
                }
            }
        }
        
        sampleApiClient.getSampleData { (result, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            if let data =  result {
                self.sampleLocalStorage.deleteAll()
                let newRecord = Sample()
                newRecord.help = data.help
                newRecord.success = data.success
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted

                do {
                    let jsonData = try encoder.encode(data.result)

                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        newRecord.jsonData = jsonString
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                
                self.sampleLocalStorage.create(item: newRecord)
                completionHandler(newRecord, nil)
            }
            else {
                completionHandler(existingRecords, nil)
            }
        }
    }
    
    func mockSampleData(completionHandler: @escaping (Sample?, Error?) -> Void) {
        //using mock data
        FileUtil().getModelData(forResource: "datastore_search", ofType: "json") {(data, error) in
            if let jsonData = data {
                let object = try! JSONDecoder().decode(SampleResponse.self, from: jsonData)

                let newRecord = Sample()
                newRecord.help = object.help
                newRecord.success = object.success
                
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted

                do {
                    let jsonData = try encoder.encode(object.result)

                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        newRecord.jsonData = jsonString
                    }
                } catch {
                    print(error.localizedDescription)
                }
                self.sampleLocalStorage.create(item: newRecord)
                completionHandler(newRecord, nil)
            }
        }
    }
}
