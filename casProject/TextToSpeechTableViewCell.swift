//
//  TextToSpeechTableViewCell.swift
//  casProject
//
//  Created by Yue Fung Lee on 8/11/2020.
//

import UIKit

class TextToSpeechTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
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
        playButton.tintColor = UIColor(named: "Accent")
        pauseButton.tintColor = UIColor(named: "Accent")
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        print("play")
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        print("pause")
    }
    
}
