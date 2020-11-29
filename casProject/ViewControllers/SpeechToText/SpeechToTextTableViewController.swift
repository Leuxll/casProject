//
//  SpeechToTextTableViewController.swift
//  casProject
//
//  Created by Yue Fung Lee on 29/11/2020.
//

import UIKit

class SpeechToTextTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.init(named: "Primary")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        fetch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadText"), object: nil)
        
    }
    
    @objc func loadList() {
        
        fetch()
        
    }
    
    func fetch() {
        do {
            Utilities.speechArray = try
                context.fetch(SpeechToTextDocument.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch  {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        Utilities.speechArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpeechToTextTableViewCell{
            
            let document = Utilities.speechArray[indexPath.row]
            
            cell.titleLabel.text = document.title
            cell.backgroundColor = UIColor(named: "Primary")
            cell.configureCell()
            cell.toText = document.document!
            cell.copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    @objc func copyButtonTapped() {
        
        let alert = UIAlertController(title: "Copied", message: "The text have been copied to your clipboard.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
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
