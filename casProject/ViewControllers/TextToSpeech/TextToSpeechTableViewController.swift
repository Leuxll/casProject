//
//  TextToSpeechTableViewController.swift
//  casProject
//
//  Created by Yue Fung Lee on 31/10/2020.
//

import UIKit

class TextToSpeechTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.init(named: "Primary")
        tableView.allowsSelection = false
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadSpeech"), object: nil)
        
    }
    
    @objc func loadList() {
        
        fetch()
        
    }
    
    func fetch() {
        
        do {
            Utilities.textArray = try context.fetch(TextToSpeechDocument.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        Utilities.textArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TextToSpeechTableViewCell {
            
            let document = Utilities.textArray[indexPath.row]
            
            cell.titleLabel.text = document.title
            cell.backgroundColor = UIColor(named: "Primary")
            cell.configureCell()
            cell.toSpeech = document.document!
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let documentToRemove = Utilities.textArray[indexPath.row]
            
            self.context.delete(documentToRemove)
            
            do {
                try self.context.save()
            } catch {
                
            }
            self.fetch()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }


}
