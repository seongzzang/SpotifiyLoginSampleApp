//
//  EnterEmailViewController.swift
//  SpotifiyLoginSampleApp
//
//  Created by 양성혜 on 2022/08/27.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigationBar 보이기
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let passoword = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: passoword) { [weak self] authResult, error in
            guard let self = self else {return}
        
            self.showMainViewController()
        }
    }
    
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
