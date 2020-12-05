//
//  SignUpVC.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 10/28/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol SignUpVCProtocol: class{
    func showAlert(alertTitle: String, message: String, actionTitle: String)
    func goToSignInVC()
    func showLoader()
    func hideLoader()
}

class SignUpVC: UIViewController {
    
    // MARK:- Properties
    var viewModel: SignUpViewModel!
    @IBOutlet var signUpView: SignUpView!
    
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceHolders()
        signUpView.setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.viewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }
    
    
    
    // MARK:- Actions
    @IBAction func signUpSubmittBtnTapped(_ sender: UIButton) {
       viewModel.signUpUser(name: signUpView.userNameTextField.text!, email: signUpView.userEmailTextField.text!, password: signUpView.userPasswordTextField.text!, age: signUpView.userAgeTextField.text!)
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        goToSignInVC()
    }
}
// MARK:- Extension Private Functions
extension SignUpVC{
    
    private func setPlaceHolders(){
        signUpView.userNameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        signUpView.userEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        signUpView.userPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        signUpView.userAgeTextField.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    
}

// MARK:- extension SignUp Presenter
extension SignUpVC: SignUpVCProtocol{
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        ShowAlertsManager.showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
    }
    
    func goToSignInVC() {
        let signInVC = SignInVC.create()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    
}
