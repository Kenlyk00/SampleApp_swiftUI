import SwiftUI

struct ContentView: View {
    var body: some View {
        var data = [DataRecord]()
        let sampleRepo = SampleRepo()
        sampleRepo.getAll { (result, error) in
            if let jsonString = result?.jsonData {
                let jsonData = jsonString.data(using: .utf8)!
                if let object = try? JSONDecoder().decode(Result.self, from: jsonData) {
                    object.records.forEach { (item) in
                        var newRecord = DataRecord.init(id: UUID(), quarter: item.quarter, volumeOfMobileData: item.volumeOfMobileData)
                        data.append(newRecord)
                    }
                }
            }
        }
        return List(data) { item in
            DataRow(data: item)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


