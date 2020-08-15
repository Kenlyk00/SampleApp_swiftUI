import Foundation

let REQUEST_MANAGER = RequestManager.sharedInstance
let TIME_OUT = 60.0
typealias JSONCompletionHandler = (String?, Error?) -> Void


struct APIConfiguration
{
    static let SERVER_PATH = "https://data.gov.sg/api/action/"
}

public struct HEADERS {
    static let urlEncoded : NSMutableDictionary = NSMutableDictionary.init(dictionary: ["Content-Type":"application/x-www-form-urlencoded; charset=UTF-8","Accept":"application/json; charset=UTF-8","cache-control": "no-cache"])
    static let appJson : NSMutableDictionary = NSMutableDictionary.init(dictionary: ["Content-Type":"application/json; charset=UTF-8", "Accept":"application/json; charset=UTF-8","cache-control": "no-cache"])
    static let multipart : NSMutableDictionary = NSMutableDictionary.init(dictionary: ["Content-type": "multipart/form-data"])
}

struct API_MODULE {
    // place holder module name
    static let XXX_MODULE = ""
    static let SAMPLE = "datastore_search?"
}

struct API_METHODS {
    static let GET = ""
    static let FIND_ITEM_BY_UUID = "/findItemByUUID?uuid="
}

struct API_TABLE_NAME
{
    // Place holder when waiting for api
    static let XXX = ""

}
