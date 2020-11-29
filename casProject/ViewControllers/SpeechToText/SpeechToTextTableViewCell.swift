//
//  SpeechToTextTableViewCell.swift
//  casProject
//
//  Created by Yue Fung Lee on 28/11/2020.
//

import UIKit

class SpeechToTextTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    var toText : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        
        titleLabel.font = UIFont(name: "Sassoon-Primary", size: 20)
        titleLabel.textColor = UIColor(named: "Accent")
        copyButton.tintColor = UIColor(named: "Accent")
        
    }

    @IBAction func copyButtonTapped(_ sender: Any) {
        
        UIPasteboard.general.string = toText
        
    }
    
}
