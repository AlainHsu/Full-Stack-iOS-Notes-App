//
//  AddNoteViewController.swift
//  Note-App
//
//  Created by Alain Hsu on 2021/7/1.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    // MARK: Initialization
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var noteTextivew: UITextView!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    var note: Note?
    var shouldUpdate = false
    
    // MARK: - UI Actions
    @IBAction func saveBtnTapped(_ sender: Any) {
        // creates a date string that we can pass in to the database
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateStr = dateFormatter.string(from: Date())
        
        // if the user is updating, update the note rather than saving
        if shouldUpdate {
            APIFunctions.share.updateNote(date: dateStr, title: titleTextfield.text!, note: noteTextivew.text!, id: note!._id)
        } else {
            APIFunctions.share.addNote(date: dateStr, title: titleTextfield.text!, note: noteTextivew.text!)
        }
        
        if titleTextfield.text != "" && noteTextivew.text != "" {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        APIFunctions.share.deleteNote(id: note!._id)
        // returns the screen back to the main screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - LifeCycle Hooks
    override func viewWillAppear(_ animated: Bool) {
        
        self.deleteBtn.isEnabled = shouldUpdate
        self.deleteBtn.title = shouldUpdate ? "Delete" : ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldUpdate {
            titleTextfield.text = note?.title
            noteTextivew.text = note?.note
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
