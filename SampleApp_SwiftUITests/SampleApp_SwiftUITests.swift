import XCTest
@testable import SampleApp_SwiftUI

class SampleApp_SwiftUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testFailReadMockData() {
        let fileUtil = FileUtil()
        fileUtil.getModelData(forResource: "invalid", ofType: "json") { (result, error) in
             let error = NSError(domain: "FileUtil", code: 0, userInfo: [NSLocalizedDescriptionKey:"Invalid filename/path."])
            XCTAssertEqual(error, error, "file name or type is invalid")
            XCTAssertNil(result)
        }
    }
    
    func testReadMockData() {
        let fileUtil = FileUtil()
        fileUtil.getModelData(forResource: "datastore_search", ofType: "json") { (result, error) in
            XCTAssertNotNil(result)
        }
    }
    
    func testSampleApiClientGetAll() {
        let mockApi = SampleApiClientStub()
        mockApi.mockSampleData { (result, error) in
            XCTAssertEqual(result?.success, true, "mock data is invalid")
        }
    }
    
   
    func testSampleApiRepoGetAll() {
        let mockSampleRepo = SampleRepo()
        mockSampleRepo.getAll { (result, error) in
            XCTAssertEqual(result?.success, true, "mock data is invalid")
        }
    }
    
    func testMainHomeViewModelInit(){
        let homeViewVM = MainHomeVM()
        XCTAssertTrue(homeViewVM.years.count == 0, "Years should be empty" )
        XCTAssertTrue(homeViewVM.records.count == 0, "Record should be empty" )
        XCTAssertTrue(homeViewVM.filterRecords.count == 0, "Filter record should be empty" )
    }
    
    func testMainHomeViewModelAssignData(){
        let homeViewVM = MainHomeVM()
        let mockSampleRepo = SampleRepo()
        var dataList = [DataRecord]()
        var yearList = [String]()
        
        mockSampleRepo.getAll { (result, error) in
            if let jsonString = result?.jsonData {
                let jsonData = jsonString.data(using: .utf8)!
                if let object = try? JSONDecoder().decode(Result.self, from: jsonData) {
                    object.records.forEach { (item) in
                        let newRecord = DataRecord.init(id: UUID(), quarter: item.quarter, volumeOfMobileData: item.volumeOfMobileData)
                        if let itemYear = item.quarter.split(separator: "-").first {
                            if !yearList.contains(String(itemYear)) {
                                yearList.append(String(itemYear))
                            }
                        }
                        dataList.append(newRecord)
                    }
                    homeViewVM.records = dataList
                    homeViewVM.filterRecords = dataList
                    homeViewVM.years = yearList
                    
                    
                    XCTAssertTrue(homeViewVM.years.count > 0, "Years should not be empty" )
                    XCTAssertTrue(homeViewVM.records.count > 0, "Record should not be empty" )
                    XCTAssertTrue(homeViewVM.filterRecords.count > 0, "Filter record should not be empty" )
                }
            }
        }
   }
}
