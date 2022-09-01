//
//  LoginViewController.swift
//  SpotifiyLoginSampleApp
//
//  Created by 양성혜 on 2022/08/27.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigationbar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        //google sign in
        //GIDSignIn.sharedInstance.presentingViewController = self
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self){ [unowned self] user, error in
            if let error = error {
                print("ERROR Goolge Sign In \(error.localizedDescription)")
                return
            }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken
            else {return}
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("ERROR Goolge Sign In \(error.localizedDescription)")
                    return
                }
            }
        }
        
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
    }
}
