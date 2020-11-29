//
//  Utilities.swift
//  casProject
//
//  Created by Yue Fung Lee on 29/11/2020.
//

import Foundation
import UIKit
 
class Utilities {
    
    static var textArray = [TextToSpeechDocument]()
    static var speechArray = [SpeechToTextDocument]()
    
    static func customLabel(_ label: UILabel) {
        
        label.font = UIFont.init(name: "Sassoon-Primary", size: 20)
        label.textColor = UIColor.init(named: "Accent")
        
    }

    static func customTextField(_ textField: UITextField) {
        
        textField.font = UIFont.init(name: "Sassoon-Primary", size: 18)
        textField.backgroundColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: "Accent")!])
        
    }
    
    static func customTextView(_ textView: UITextView) {
        
        textView.backgroundColor = UIColor.init(named: "Primary")
        textView.isEditable = false
        textView.textColor = UIColor.init(named: "Accent")
        textView.font = UIFont.init(name: "Sassoon-Primary", size: 18)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        
    }
    
    static func customButton(_ button: UIButton) {
        
        button.backgroundColor = UIColor.init(named: "Accent")
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Sassoon-Primary", size: 18)
        
    }
    
}
