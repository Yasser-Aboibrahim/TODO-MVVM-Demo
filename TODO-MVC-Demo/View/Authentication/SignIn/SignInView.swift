//
//  SignInView.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SignInView: UIView{
    
    // MARK:- Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var signInSubmittBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    func setup(){
        setupTextField(userEmailTextField, placeHolder: "Email",isSceure: false)
        setupTextField(userPasswordTextField, placeHolder: "Password",isSceure: true)
        SignInSubmittBtn()
        setupUnderLineButton(createAccountBtn, title: "Create Account?")
    }
}

// MARK:- Private Method
extension SignInView {
    private func setupBackGround(){
        self.backgroundColor = .purple
    }
    private func setupTextField(_ textField: UITextField, placeHolder: String, isSceure: Bool = false){
        textField.backgroundColor = .purple
        textField.placeholder = placeHolder
        textField.font = UIFont.init(name: textField.font!.fontName, size: 20)
        textField.isSecureTextEntry = isSceure
    }
    private func SignInSubmittBtn(){
        signInSubmittBtn.backgroundColor = .white
        signInSubmittBtn.layer.cornerRadius = signInSubmittBtn.frame.height / 2
        signInSubmittBtn.setTitle("Submitt", for: .normal)
    }
    private func setupUnderLineButton(_ button: UIButton, title: String){
        button.layer.borderWidth = 0.0
        let attributedString = NSAttributedString(string: title, attributes:[
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle:1.0
            ])
        button.setAttributedTitle(attributedString, for: .normal)
    }
}
