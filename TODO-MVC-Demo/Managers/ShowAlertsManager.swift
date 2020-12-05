//
//  ShowAlertFunctions.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/11/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit



class ShowAlertsManager{
    
    class func showAlertWithCancel(alertTitle: String,message: String,actionTitle: String){
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        //present(alert,animated: true)
    }
}

