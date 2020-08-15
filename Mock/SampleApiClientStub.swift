//
//  SampleApiClientStub.swift
//  SampleApp_SwiftUI
//
//  Created by deskera on 15/8/20.
//  Copyright © 2020 ken. All rights reserved.
//

import Foundation
class SampleApiClientStub {
    func mockSampleData(completionHandler: @escaping (SampleResponse?, Error?) -> Void) {
        //using mock data
        FileUtil().getModelData(forResource: "datastore_search", ofType: "json") {(data, error) in
            if let jsonData = data {
                let object = try! JSONDecoder().decode(SampleResponse.self, from: jsonData)
                completionHandler(object, nil)
            }
            else {
                 let error = NSError(domain: "FileUtil", code: 0, userInfo: [NSLocalizedDescriptionKey:"Error reading mock data"])
                completionHandler(nil, error)
            }
        }
    }
}
