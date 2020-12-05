//
//  SignUpView.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/22/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SignUpView: UIView{
    
    // MARK:- Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userAgeTextField: UITextField!
    @IBOutlet weak var signUpSubmittBtn: UIButton!
    @IBOutlet weak var signIntBtn: UIButton!
    
    // MARK:- Public Method
    func setup(){
        //setupBackGround()
        setupTextField(userEmailTextField, placeHolder: "Email")
        setupTextField(userPasswordTextField, placeHolder: "Password",isSceure: true)
        setupTextField(userAgeTextField, placeHolder: "Age",isSceure: false)
        setupTextField(userNameTextField, placeHolder: "Name",isSceure: false)
        SignUpSubmittBtn()
        setupUnderLineButton(signIntBtn, title: "Sign In")
    }
}

// MARK:- Private Method
extension SignUpView {
    private func setupBackGround(){
        self.backgroundColor = .purple
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String, isSceure: Bool = false){
        textField.backgroundColor = .purple
        textField.placeholder = placeHolder
        textField.font = UIFont.init(name: textField.font!.fontName, size: 20)
        textField.isSecureTextEntry = isSceure
    }
    
    private func SignUpSubmittBtn(){
        signUpSubmittBtn.backgroundColor = .white
        signUpSubmittBtn.layer.cornerRadius = signUpSubmittBtn.frame.height / 2
        signUpSubmittBtn.setTitle("Submitt", for: .normal)
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
