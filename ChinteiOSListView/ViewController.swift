//
//  ViewController.swift
//  ChinteiOSListView
//
//  Created by anand chinte on 3/29/21.
//
import FirebaseFirestore
import UIKit
import AppCenter
import AppCenterCrashes

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if let text = textField.text, !text.isEmpty {
            saveData(text: text)
            textField.text = ""
            getData()
        }
    }
    

    let db = Firestore.firestore()
    override func viewDidLoad() {
        
        AppCenter.start(withAppSecret: "71f7fefc-8ead-4893-a40e-aa3e66c51f39", services:[
          Crashes.self
        ])
        
        super.viewDidLoad()
        getData()
        //load image
        imageOne.load(urlString: "https://firebasestorage.googleapis.com/v0/b/chintefirebase1.appspot.com/o/friends%2Fanand.JPG?alt=media&token=3df64652-572b-46cd-a158-42764524b468")
    }
    
    
    func saveData(text: String){
        let docRef = db.document("iOS/example")
        docRef.setData(["text" : text])
    }
    
    func getData(){
        let docRef = db.document("iOS/example")
        docRef.getDocument { (snapshot, error) in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            guard let text = data["text"] as? String else {
                return
            }
            DispatchQueue.main.async {
                self.displayLabel.text = text
            }
        }
    }


}

