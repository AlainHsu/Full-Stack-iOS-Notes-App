//
//  ViewController.swift
//  Note-App
//
//  Created by Alain Hsu on 2021/6/28.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var notes = [Note]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].note
        return cell
    }


    @IBOutlet weak var notesTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        notesTableview.delegate = self
        notesTableview.dataSource = self
    }
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            notes =  try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
        } catch  {
            print("Failed to decode!")
        }
    }
}
