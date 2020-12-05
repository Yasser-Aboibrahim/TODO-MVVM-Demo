//
//  SignInPresenter.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/11/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

protocol SignInViewModelProtocol: class{
    func logInUser(email: String, password: String)
}

class SignInViewModel{
    
    //MARK:- Properties
    private weak var view: SignInVCProtocol!
    
    init(view: SignInVCProtocol){
        self.view = view
    }
    
    // MARK:- Private Methods
    private func userDataValidator(userEmail: String, Password: String)-> Bool{
        guard ValidationManager.shared().isValidEmail(email: userEmail) else{
            return false
        }
        guard ValidationManager.shared().isValidPassword(password: Password) else{
            return false
        }
        return true
    }
    
    private func isDataEntered(userEmail: String, Password: String)-> Bool{
        guard ValidationManager.shared().isEmptyEmail(email: userEmail) else{
            view.showAlert(alertTitle: "Incompleted Data Entry",message: "Please Enter Email",actionTitle: "Dismiss")
            return false
        }
        guard ValidationManager.shared().isEmptyPassword(password: Password) else{
            view.showAlert(alertTitle: "Incompleted Data Entry",message: "Please Enter Password",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    private func isValidRegex(userEmail: String, Password: String)-> Bool{
        guard ValidationManager.shared().isValidEmail(email: userEmail) else{
            view.showAlert(alertTitle: "Wrong Email Form",message: "Please Enter Valid email(a@a.com)",actionTitle: "Dismiss")
            return false
        }
        guard ValidationManager.shared().isValidPassword(password: Password) else{
            view.showAlert(alertTitle: "Wrong Password Form",message: "Password need to be : \n at least one uppercase \n at least one digit \n at leat one lowercase \n characters total",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
     private func signInWithEnteredData(email: String, password: String){
  
        view.showLoader()
        APIManager.loginAPIRouter(email: email, password: password){ response in
            switch response{
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                    self.view.showAlert(alertTitle: "Error",message: "Incorrect Email and Password",actionTitle: "Dismiss")
                }else{
                    self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
                    print(error.localizedDescription)
                }
            case .success(let result):
                print(result.token)
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().userId = result.user.id
                self.view.goToTodoListVC()
            }
            self.view.hideLoader()
        }
    }
}

// MARK:- Extension SignInViewModel protocol Funcs
extension SignInViewModel: SignInViewModelProtocol{
    func logInUser(email: String, password: String){
        if isDataEntered(userEmail: email, Password: password){
            if isValidRegex(userEmail: email, Password: password){
                signInWithEnteredData(email: email, password: password)
            }
        }
    }
}
