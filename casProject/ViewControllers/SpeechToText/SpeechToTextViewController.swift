//
//  SpeechToTextViewController.swift
//  casProject
//
//  Created by Yue Fung Lee on 31/10/2020.
//

import UIKit
import Speech

class SpeechToTextViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var addDocumentButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task : SFSpeechRecognitionTask!
    var started : Bool = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(named: "Primary")
        titleLabel.text = "Title of Document"
        textViewLabel.text = "Recorded Document"
        
        Utilities.customLabel(titleLabel)
        Utilities.customLabel(textViewLabel)
        Utilities.customTextField(titleTextField)
        Utilities.customTextView(textView)
        Utilities.customButton(startRecordingButton)
        Utilities.customButton(addDocumentButton)
        
        requestPermission()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func startRecordingTapped(_ sender: Any) {
        
        started = !started
        view.endEditing(true)
        
        if started {
            
            startSpeechRecognization()
            startRecordingButton.setTitle("Stop Recording", for: .normal)
            
        } else {
            
            cancelSpeechRecognization()
            startRecordingButton.setTitle("Start Recording", for: .normal)
            
        }
        
    }
    
    @IBAction func addDocumentTapped(_ sender: Any) {
        
        if (titleTextField.text!.isEmpty || textView.text.isEmpty) {
            
            let alert = UIAlertController(title: "Alert", message: "Please fill in all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
                
                self.dismiss(animated: true, completion: nil)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let newDocument = SpeechToTextDocument(context: context)
            newDocument.title = titleTextField.text
            newDocument.document = textView.text
            
            do {
                try context.save()
            } catch  {
                
            }
            
            navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadText"), object: nil)
            
        }
        
    }
    
    func requestPermission() {
        self.startRecordingButton.isEnabled = false
        SFSpeechRecognizer.requestAuthorization { (authState) in
            OperationQueue.main.addOperation {
                if authState == .authorized {
                    print("Accepted")
                    self.startRecordingButton.isEnabled = true
                } else if authState == .denied{
                    
                    self.alertView(message: "User denied the permission, please enable it in system preferences")
                    
                } else if authState == .notDetermined {
                    
                    self.alertView(message: "There is not speech recognition in the phone")
                    
                } else if authState == .restricted {
                    
                    self.alertView(message: "User has been restricted for using the speech recognization")
                    
                }
            }
            
        }
    }
    
    func alertView(message: String) {
        
        let controller  = UIAlertController.init(title: "Error occured", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        self.present(controller, animated: true, completion: nil)
    }
    
    func startSpeechRecognization() {
        
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            
            self.request.append(buffer)
            
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            alertView(message: "Error in starting engine. \(error.localizedDescription)")
        }
        
        guard let myRecognization = SFSpeechRecognizer() else {
            self.alertView(message: "Recognization is not allowed on your device.")
            return
        }
        
        if !myRecognization.isAvailable {
            self.alertView(message: "Please try again after some time.")
        }
        
        task = speechRecognizer?.recognitionTask(with: request, resultHandler: { (response, error) in
            guard let response = response else {
                
                if error != nil {
                    self.alertView(message: error.debugDescription)
                } else {
                    self.alertView(message: "There is a problem with giving the repsonse")
                }
                
                return
            }
            
            let message = response.bestTranscription.formattedString
            self.textView.text = message
            
        })
        
    }
    
    func cancelSpeechRecognization() {
        
        task.finish()
        task.cancel()
        task = nil
        
        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }

}
