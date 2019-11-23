//
//  LoginViewController.swift
//  Inst
//
//  Created by Chakane Shegog on 11/16/19.
//  Copyright © 2019 Chakane Shegog. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func onSign(_ sender: Any) {
        let userName = userNameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: userName, password: password){
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = userNameField.text
        user.password = passwordField.text

        // Attempt to sign up if good procees
        user.signUpInBackground{
            (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        
        //user.email = "email@example.com"
        // other fields can be set just like with PFObject
        // user["phone"] = "415-392-0202"
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
