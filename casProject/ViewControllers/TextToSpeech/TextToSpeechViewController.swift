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
    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scanDocumentButton: UIButton!
    @IBOutlet weak var addDocumentButton: UIButton!
    
    var textRecognitionRequest = VNRecognizeTextRequest()
    var recognizedText = ""
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(named: "Primary")
        titleLabel.text = "Title of Document"
        textViewLabel.text = "Scanner Document"
        
        Utilities.customLabel(titleLabel)
        Utilities.customLabel(textViewLabel)
        Utilities.customTextField(titleTextField)
        Utilities.customTextView(textView)
        Utilities.customButton(scanDocumentButton)
        Utilities.customButton(addDocumentButton)
        
        recognitionRequest()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        }
    
    func recognitionRequest() {
        
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
        
        if (titleTextField.text!.isEmpty || textView.text.isEmpty) {
            
            let alert = UIAlertController(title: "Alert", message: "Please fill in all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
                
                self.dismiss(animated: true, completion: nil)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let newDocument = TextToSpeechDocument(context: context)
            newDocument.title = titleTextField.text
            newDocument.document = textView.text
            
            do {
                try context.save()
            } catch  {
                
            }
            
                navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadSpeech"), object: nil)
            
            }
        
        }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        }
    
    }
    

