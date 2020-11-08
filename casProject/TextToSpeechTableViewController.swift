//
//  TextToSpeechTableViewController.swift
//  casProject
//
//  Created by Yue Fung Lee on 31/10/2020.
//

import UIKit

class TextToSpeechTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.init(named: "Primary")
        tableView.reloadData()
        tableView.allowsSelection = false
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        Utilities.textArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TextToSpeechTableViewCell {
            
            cell.titleLabel.text = Utilities.textArray[indexPath.row].title
            cell.backgroundColor = UIColor(named: "Primary")
            cell.configureCell()
            return cell
        } else {
            return UITableViewCell()
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
