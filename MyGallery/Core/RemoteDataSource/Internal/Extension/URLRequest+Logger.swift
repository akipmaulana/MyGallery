//
//  URLRequest+Logger.swift
//  MyGallery
//
//  Created by Akip Maulana on 19/10/23.
//

import Foundation

extension URLRequest {
    func debug() {
        print("\(self.httpMethod ?? "-") \(self.url ?? URL(string: ""))")
        print("Headers:")
        print(self.allHTTPHeaderFields ?? [:])
        print("Body")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}
