//
//  TextToSpeechViewController.swift
//  casProject
//
//  Created by Yue Fung Lee on 31/8/2020.
//  Copyright © 2020 Yue Fung Lee. All rights reserved.
//

import UIKit
import VisionKit
import Vision

class TextToSpeechViewController: UIViewController, VNDocumentCameraViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scanDocumentButton: UIButton!
    @IBOutlet weak var addDocumentButton: UIButton!
    
    var textRecognitionRequest = VNRecognizeTextRequest()
    var recognizedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont.init(name: "Sassoon-Primary", size: 20)
        titleLabel.text = "Enter the title of your new post"
        titleLabel.textColor = UIColor.init(named: "Accent")
        
        textFieldLabel.font = UIFont.init(name: "Sassoon-Primary", size: 20)
        textFieldLabel.text = "Scanned Document"
        textFieldLabel.textColor = UIColor.init(named: "Accent")
        
        titleTextField.placeholder = "Title"
        titleTextField.backgroundColor = .white
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Title",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: "Accent")!])

        textView.backgroundColor = UIColor.init(named: "Primary")
        textView.isEditable = false
        textView.textColor = UIColor.init(named: "Accent")
        textView.font = UIFont.init(name: "Sassoon-Primary", size: 18)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        view.backgroundColor = UIColor.init(named: "Primary")
        
        scanDocumentButton.backgroundColor = UIColor.init(named: "Accent")
        scanDocumentButton.layer.cornerRadius = 20
        scanDocumentButton.tintColor = UIColor.white
        scanDocumentButton.titleLabel?.font = UIFont(name: "Sassoon-Primary", size: 18)
        
        addDocumentButton.backgroundColor = UIColor.init(named: "Accent")
        addDocumentButton.layer.cornerRadius = 20
        addDocumentButton.tintColor = UIColor.white
        addDocumentButton.titleLabel?.font = UIFont(name: "Sassoon-Primary", size: 18)
        
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
    
         textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
                if let results = request.results, !results.isEmpty {
                    if let requestResults = request.results as? [VNRecognizedTextObservation] {
                        self.recognizedText = ""
                        for observation in requestResults {
                            guard let candidiate = observation.topCandidates(1).first else { return }
                              self.recognizedText += candidiate.string
                            self.recognizedText += "\n"
                        }
                        self.textView.text = self.recognizedText
                    }
                }
            })
        
        }
    
    @IBAction func scanDocumentTapped(_ sender: Any) {
        
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        self.present(documentCameraViewController, animated: true, completion: nil)
        
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        let image = scan.imageOfPage(at: 0)
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
        controller.dismiss(animated: true)
        
        }
    
    @IBAction func addDocumentButtonTapped(_ sender: Any) {
        
        Utilities.textArray.append(Document(title: titleTextField.text!, document: textView.text))
        navigationController?.popViewController(animated: true)
    }
    
    }
    

