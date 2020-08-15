import SwiftUI
import Combine

struct DataRecord: Identifiable {
    var id = UUID()
    var quarter: String
    var volumeOfMobileData: String
}

class MainHomeVM: ObservableObject {
    
    @Published var records: [DataRecord] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    
    @Published var filterRecords: [DataRecord] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    
    @Published var quarter: String = "" {
        didSet {
            didChange.send(self)
        }
    }

    @Published var selectedYear: String = "" {
       didSet {
           didChange.send(self)
       }
    }
    
    @Published var years: [String] = [] {
       didSet {
           didChange.send(self)
       }
    }
    
    
    var didChange = PassthroughSubject<MainHomeVM, Never>()
    
    init() {
        let sampleRepo = SampleRepo()
        var dataList = [DataRecord]()
        var yearList = [String]()
        yearList.append("---- Select Year ----")
        
        sampleRepo.getAll { (result, error) in
            if let jsonString = result?.jsonData {
                let jsonData = jsonString.data(using: .utf8)!
                if let object = try? JSONDecoder().decode(Result.self, from: jsonData) {
                    object.records.forEach { (item) in
                        
                        if let itemYear = item.quarter.split(separator: "-").first {
                            guard let yearNum = Int(String(itemYear)) else {
                                return
                            }
                            if(yearNum >= 2008 && yearNum <= 2018) {
                                let newRecord = DataRecord.init(id: UUID(), quarter: item.quarter, volumeOfMobileData: item.volumeOfMobileData)
                                dataList.append(newRecord)
                                if !yearList.contains(String(itemYear)) {
                                    yearList.append(String(itemYear))
                                }
                            }
                        }
                    }
                    self.records = dataList
                    self.filterRecords = dataList
                    self.years = yearList
                }
            }
        }
    }
    
    func getSubTitle() -> String{
        var subTitle = ""
        if(self.selectedYear != "") {
            subTitle += " " + self.selectedYear
            if(self.quarter != "" && self.quarter != "ALL") {
                subTitle += ", " + self.quarter
            }
        }
        return subTitle
        
    }
    
    func updateSelectedYear(value: Int) {
        if (value < self.years.count) {
            self.selectedYear = self.years[value]
            self.filterRecords = self.records.filter({ (item) -> Bool in
                item.quarter.contains(self.selectedYear)
            })
        }
    }
    
    func updateQurter(value: String) {
        if(selectedYear != "") {
            self.quarter = value
            if (value == "ALL") {
               self.filterRecords = self.records.filter({ (item) -> Bool in
                   item.quarter.contains(self.selectedYear)
               })
            }
            else {
               let queryString = self.selectedYear + "-" + value
               self.filterRecords = self.records.filter({ (item) -> Bool in
                   item.quarter.contains(queryString)
               })
            }
        }
    }
    
    func resetData() {
        self.selectedYear = ""
        self.filterRecords = self.records
    }
}
