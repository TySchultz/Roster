//
//  AddPlayerViewController.swift
//  Roster
//
//  Created by Ty Schultz on 10/22/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import RealmSwift
import LTMorphingLabel
class AddPlayerViewController: UIViewController {
    
    var realm : Realm?

    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var subTitle: LTMorphingLabel!
    
    
    let phrases = ["On deck?","Up to bat?","Ready to go?","Suited Up?"]
    
    var bigCircle = 0
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addButton.layer.cornerRadius = 8.0
        addMoreButton.layer.cornerRadius = 8.0
        addButton.backgroundColor = TSBlue
        addMoreButton.backgroundColor = TSGreen
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 28, width: self.view.frame.width, height: self.view.frame.height+100))
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 8.0
        self.view.addSubview(backgroundView)
        self.view.sendSubview(toBack: backgroundView)
        
        animateHeader()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block:{(timer) in
            self.animateHeader()
        })
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.bottomConstraint.constant = keyboardHeight + 16.0
            self.view.needsUpdateConstraints()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.textField.resignFirstResponder()
        self.disissKeyboard()
        
    }
    
    func disissKeyboard() {
        
        for sub in self.view.subviews {
            if sub.isFirstResponder {
                sub.alpha = 0.0
            }
        }
    }
    
    func animateHeader () {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.bigCircle += 1
            if self.bigCircle == 4 {
                self.bigCircle = 0
            }
            
            self.subTitle.text = self.phrases[self.bigCircle]
            
            }, completion:nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        self.textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addAnother(_ sender: UIButton) {
        
        let tmpLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.textField.frame.width, height: self.textField.frame.height))
        tmpLabel.text = self.textField.text! + "        ✓"
        tmpLabel.font = self.textField.font
        tmpLabel.textColor = UIColor.blue
        
        self.textField.addSubview(tmpLabel)
        
        createPlayer()
        self.textField.text = ""
        self.textField.placeholder = ""

        UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [.curveEaseInOut], animations: {
            var frame = tmpLabel.frame
            frame.origin.y += self.textField.frame.height
            tmpLabel.frame = frame
            tmpLabel.alpha = 0.0
        }) { (Bool) in
            self.textField.placeholder = "name"
            tmpLabel.removeFromSuperview()
        }
        
    }
    @IBAction func addPlayer(_ sender: UIButton) {
        createPlayer()
        self.textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func createPlayer() {
        guard self.textField.text != "" else {return}
        realm = try! Realm()
        let p = Player()
        p.name = self.textField.text!
        p.startTime = NSDate()
        p.totalTime = 0.0
        p.inPlay = false
        p.plusTotal = 0
        p.minusTotal = 0
        try! realm!.write {
            realm!.add(p, update: false)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
