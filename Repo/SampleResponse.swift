import Foundation

// MARK: - Welcome
class SampleResponse: Codable {
    let help: String
    let success: Bool
    let result: Result

    init(help: String, success: Bool, result: Result) {
        self.help = help
        self.success = success
        self.result = result
    }
}

// MARK: - Result
class Result: Codable {
    let resourceID: String
    let fields: [Field]
    let records: [Record]
    let links: Links
    let total: Int

    enum CodingKeys: String, CodingKey {
        case resourceID = "resource_id"
        case fields, records
        case links = "_links"
        case total
    }

    init(resourceID: String, fields: [Field], records: [Record], links: Links, total: Int) {
        self.resourceID = resourceID
        self.fields = fields
        self.records = records
        self.links = links
        self.total = total
    }
}

// MARK: - Field
class Field: Codable {
    let type, id: String

    init(type: String, id: String) {
        self.type = type
        self.id = id
    }
}

// MARK: - Links
class Links: Codable {
    let start, next: String

    init(start: String, next: String) {
        self.start = start
        self.next = next
    }
}

// MARK: - Record
class Record: Codable {
    let volumeOfMobileData, quarter: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case volumeOfMobileData = "volume_of_mobile_data"
        case quarter
        case id = "_id"
    }

    init(volumeOfMobileData: String, quarter: String, id: Int) {
        self.volumeOfMobileData = volumeOfMobileData
        self.quarter = quarter
        self.id = id
    }
}
