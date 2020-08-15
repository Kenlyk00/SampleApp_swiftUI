import UIKit
import ObjectMapper

protocol BasicMapProtocol: Mappable {
    associatedtype T
    var data: [T]? {get set}
}
