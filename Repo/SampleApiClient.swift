import Foundation
import Alamofire
import ObjectMapper

class SampleApiClient{

    func getSampleData(resourceId: String =  "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", completionHandler: @escaping (SampleResponse?, Error?) -> Void) {
        let apiUrl = "\(APIConfiguration.SERVER_PATH)" + "\(API_MODULE.SAMPLE)"  + "resource_id=" + resourceId
        
        REQUEST_MANAGER.withGET(endPointUrl: apiUrl, param: nil, headers: nil) { (data, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            if let jsonString = data {
                let jsonData = jsonString.data(using: .utf8)!
                let object = try! JSONDecoder().decode(SampleResponse.self, from: jsonData)
                completionHandler(object, nil)
            }
            
        }
    }
}
