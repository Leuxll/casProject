//
//  TextToSpeechTableViewCell.swift
//  casProject
//
//  Created by Yue Fung Lee on 8/11/2020.
//

import UIKit
import AVFoundation

class TextToSpeechTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    var toSpeech : String = ""
    
    private let synthesizer = AVSpeechSynthesizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func say(_ phrase: String) {
        
        let utterance = AVSpeechUtterance(string: phrase)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
        
    }
    
    func configureCell() {
        
        titleLabel.font = UIFont(name: "Sassoon-Primary", size: 20)
        titleLabel.textColor = UIColor(named: "Accent")
        playButton.tintColor = UIColor(named: "Accent")
        pauseButton.tintColor = UIColor(named: "Accent")
        
    }

    
    @IBAction func playTapped(_ sender: UIButton) {
        
        say(toSpeech)
        
    }
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
}
