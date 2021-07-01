//
//  APIFunctions.swift
//  Note-App
//
//  Created by Alain Hsu on 2021/6/29.
//

import Foundation
import Alamofire

// MARK: - Custom Notes struct
struct Note: Decodable {
    var title: String
    var date: String
    var _id: String
    var note: String
}

// MARK: - Functions that interact with API
class APIFunctions {
    
    // Sets our custom data delegate
    var delegate: DataDelegate?
    // Creates an instance of the class so the other files can interact with it
    static let share = APIFunctions()
    
    // Fetches notes from database
    func fetchNotes() {
        AF.request("http://192.168.0.3:8081/fetch").responseJSON { res in
            // Converts the reponse into utf8 string format
            let data = String(data: res.data!, encoding: .utf8)
            // Fires off the custom delegate in the view controller
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    // Adds a note to the server, passing the arguments as headers
    func addNote(date: String, title: String, note: String) {
        AF.request("http://192.168.0.3:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "note": note, "date": date]).responseJSON { res in
            print(res)
        }
    }
    
    // Update a note from the server, passing the arguments as headers
    func updateNote(date: String, title: String, note: String, id: String) {
        AF.request("http://192.168.0.3:8081/update", method: .post, headers: ["title": title, "note": note, "date": date, "id": id]).responseJSON { res in
            print(res)
        }
    }
    
    // Deletes a note from the server, passing the notes id as a header
    func deleteNote(id: String) {
        AF.request("http://192.168.0.3:8081/delete", method: .post, headers: ["id": id]).responseJSON { res in
            print(res)
        }
    }
}
