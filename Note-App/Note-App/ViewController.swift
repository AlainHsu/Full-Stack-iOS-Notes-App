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

class ViewController: UIViewController, UITableViewDelegate {

    // MARK: - Initialization

    @IBOutlet weak var notesTableview: UITableView!
    var notes = [Note]()

    // MARK: - Segue Data

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateNoteSegue" {
            // passes the note and tells the view controller to update instead to add
            let vc = segue.destination as! AddNoteViewController
            vc.note = notes[notesTableview.indexPathForSelectedRow!.row]
            vc.shouldUpdate = true
        }
    }

    // MARK: - LifeCycle Hooks

    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.share.delegate = self

        notesTableview.delegate = self
        notesTableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        // Update the notes array
        APIFunctions.share.fetchNotes()
    }
}

// MARK: - Custom Delegates

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            notes = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
        } catch {
            print("Failed to decode!")
        }

        notesTableview.reloadData()
    }
}

// MARK: - TableView Dalegates

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.titleLabel?.text = notes[indexPath.row].title
        cell.noteLabel?.text = notes[indexPath.row].note
        cell.dateLabel?.text = notes[indexPath.row].date
        return cell
    }
}
