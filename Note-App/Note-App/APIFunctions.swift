//
//  APIFunctions.swift
//  Note-App
//
//  Created by Alain Hsu on 2021/6/29.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var title: String
    var data: String
    var _id: String
    var note: String
}

class APIFunctions {
    var delegate: DataDelegate?


    func fetchNotes() {
        AF.request("http://192.168.0.3:8081/fetch").response { res in
            print(res.data!)

            let data = String(data: res.data!, encoding: .utf8)

            self.delegate?.updateArray(newArray: data!)
        }
    }
}
