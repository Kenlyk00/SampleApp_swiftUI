import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
    
    class var sharedInstance :RequestManager {
        struct Singleton {
            static let instance = RequestManager()
        }
        return Singleton.instance
    }
    
    func withGET(endPointUrl : String, param : Parameters? = nil, headers : [String: String]? = nil, completionHandler: @escaping JSONCompletionHandler)
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TIME_OUT
        
        var parameters : Parameters? = nil
        if let temp = param{
            parameters = temp as Parameters
        }
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        sessionManager.request(endPointUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response) in
            sessionManager.session.invalidateAndCancel()
            sessionManager.session.finishTasksAndInvalidate()
            switch response.result {
            case .success(_):
                if let data = response.data, let json = String(data: data, encoding: String.Encoding.utf8){
                    completionHandler(json,nil)
                }
                else {
                    completionHandler(nil, response.error)
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                    completionHandler(nil, error)
                } else {
                    completionHandler(nil, error)
                }
                break
            }
        }
    }
    
    func withGETHeader(endPointUrl : String, completionHandler: @escaping JSONCompletionHandler)
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TIME_OUT
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        sessionManager.request(endPointUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response) in
            sessionManager.session.invalidateAndCancel()
            sessionManager.session.finishTasksAndInvalidate()
            switch response.result {
            case .success(_):
                if let data = response.data, let json = String(data: data, encoding: String.Encoding.utf8){
                    completionHandler(json, nil)
                }
                else {
                    completionHandler(nil,response.error )
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                    completionHandler(nil, error)
                } else {
                    completionHandler(nil, error)
                }
                break
            }
        }
    }
    
    func withDELETE(endPointUrl : String, param : Parameters? = nil, headers : NSMutableDictionary? = nil ) -> String
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TIME_OUT
        var val = ""
        
        var parameters : Parameters? = nil
        if let temp = param{
            parameters = temp as Parameters
        }
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        sessionManager.request(endPointUrl, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response) in
            sessionManager.session.invalidateAndCancel()
            sessionManager.session.finishTasksAndInvalidate()
            switch response.result {
            case .success(_):
                if let data = response.data, let json = String(data: data, encoding: String.Encoding.utf8){
                    val = json
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                    val = "Error"
                } else {
                    val = "Error"
                }
                break
            }
        }
        return val
    }
    
    func withPOST(endPointUrl : String, param : Parameters? = nil, headers : NSMutableDictionary? = nil, completionHandler: @escaping JSONCompletionHandler)
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TIME_OUT
        
        var parameters : Parameters? = nil
        if let temp = param{
            parameters = temp as Parameters
        }
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        sessionManager.request(endPointUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
            (response) in
            sessionManager.session.invalidateAndCancel()
            sessionManager.session.finishTasksAndInvalidate()
            switch response.result {
            case .success(_):
                if let data = response.data, let json = String(data: data, encoding: String.Encoding.utf8){
//                    print(json)
                    completionHandler(json, nil)
                }
                else {
                    completionHandler(nil, response.error)
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut || error._code == NSURLErrorNotConnectedToInternet {
                    completionHandler(nil, error)
                } else {
                    completionHandler(nil, error)
                }
                break
            }
        }
    }
    
    func postWithJsonData(endPointUrl: URLRequest?, queue: DispatchQueue? = nil, completionHandler: @escaping JSONCompletionHandler) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TIME_OUT
        guard endPointUrl != nil else {
            completionHandler(nil, nil)
            return
        }
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        sessionManager.request(endPointUrl!).responseJSON {
            (response) in
//            print((endPointUrl?.url?.absoluteString)!)
//            print(endPointUrl?.httpBody?.toString())
//            print("Response Error: " + "\(response.error)")
//            print("Response Status Code: " + "\(response.response?.statusCode)")
//            print("Response Result: " + "\(response)")
//            print("Response Time: " + "\(response.timeline.totalDuration)")
            self.printLog(actionName: (endPointUrl?.url?.absoluteString)!, message: "postWithJsonData", desc: response.description)
        
            sessionManager.session.invalidateAndCancel()
            sessionManager.session.finishTasksAndInvalidate()
            switch response.result {
                
            case .success(_):
                if response.response?.statusCode == 200 {
                    if let data = response.data, let json = String(data: data, encoding: String.Encoding.utf8){
                        completionHandler(json, nil)
                    }
                }
                else {
                    if let json = response.data {
                        do{
                            let data = try JSON(data: json)
                            let errorMsg = data["error"]["display_message"]
                            var error: NSError
                            if errorMsg.stringValue != "" {
                                error =  NSError(domain:"", code:response.response!.statusCode, userInfo:[ NSLocalizedDescriptionKey: errorMsg.stringValue])
                            } else {
                                error =  NSError(domain:"", code:response.response!.statusCode, userInfo:[ NSLocalizedDescriptionKey:""])
                            }

                            completionHandler(nil, error)
                        }
                        catch{
                            let msg = "Error Occured. Please Try Again."
                            let error =  NSError(domain:"", code:response.response!.statusCode, userInfo:[ NSLocalizedDescriptionKey: msg])
                            completionHandler(nil, error)
                        }
                    }
                    else {
                        let msg = "Error Occured. Please Try Again."
                        let error =  NSError(domain:"", code:response.response!.statusCode, userInfo:[ NSLocalizedDescriptionKey: msg])
                        completionHandler(nil, error)
                    }
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    completionHandler(nil, error)
                } else if (error._code == NSURLErrorNotConnectedToInternet) {
                    completionHandler(nil, error)
                } else {
                    completionHandler(nil, error)
                }
                break
            }
        }
    }
    
 
    func printLog(actionName:String, message:String, desc:String)
    {
        print("Action Name: " + actionName + " Message: " + message + " Desc: " + desc)
    }
    
}
