//
//  ViewController.swift
//  casProject
//
//  Created by Yue Fung Lee on 25/8/2020.
//  Copyright © 2020 Yue Fung Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textToSpeech: UIButton!
    @IBOutlet weak var textToSpeechLabel: UILabel!
    @IBOutlet weak var speechToText: UIButton!
    @IBOutlet weak var speechToTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(named: "Primary")
       
        speechToText.setBackgroundImage(UIImage(systemName: "mic.fill"), for: .normal)
        speechToText.tintColor = UIColor.init(named: "Accent")
        
        speechToTextLabel.text = "Speech to Text"
        speechToTextLabel.font = UIFont(name: "Sassoon-Primary", size: 30)
                speechToTextLabel.textColor = UIColor.init(named: "Accent")
        speechToTextLabel.textAlignment = .center
        
        textToSpeech.setBackgroundImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        textToSpeech.tintColor = UIColor.init(named: "Accent")
        
        textToSpeechLabel.text = "Text to Speech"
        textToSpeechLabel.font = UIFont(name: "Sassoon-Primary", size: 30)
        textToSpeechLabel.textColor = UIColor.init(named: "Accent")
        textToSpeechLabel.textAlignment = .center
        
    }

    @IBAction func textToSpeechTapped(_ sender: Any) {
    }
    
    @IBAction func speechToTextTapped(_ sender: Any) {
    }
    
}

