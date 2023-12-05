//
//  MockResponse.swift
//  MVVMDemoTests
//
//  Created by Rushi Sangani on 05/12/2023.
//

import Foundation

// MARK: - MockResponse

struct MockResponse {
    static var postAsData: Data {
        let json = "{\r\n\"userId\": 1,\r\n\"id\": 1,\r\n\"title\": \"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\",\r\n\"body\": \"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\"\r\n}"
        return json.data(using: .utf8)!
    }
    
    static var dummyData: Data {
        "dummyText".data(using: .utf8)!
    }
}
