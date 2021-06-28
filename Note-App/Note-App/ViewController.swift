//
//  ViewController.swift
//  Note-App
//
//  Created by Alain Hsu on 2021/6/28.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        cell.textLabel?.text = "Note"
        return cell
    }
    

    @IBOutlet weak var notesTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTableview.delegate = self
        notesTableview.dataSource = self
    }


}

