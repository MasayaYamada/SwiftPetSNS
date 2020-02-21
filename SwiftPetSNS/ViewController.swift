//
//  ViewController.swift
//  SwiftPetSNS
//
//  Created by Yamada, Masaya on 2/20/20.
//  Copyright © 2020 Yamada, Masaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameTextField.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let usrname = UserDefaults.standard.object(forKey: "userName"){
            
            performSegue(withIdentifier: "next", sender: nil)
            
            
        }
        
        
    }
    
    
    
    @IBAction func login(_ sender: Any) {
        
        let ud = UserDefaults.standard
        ud.set(userNameTextField.text, forKey: "userName")
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTextField.resignFirstResponder()
    }
    
    
    
}

