//
//  String+Trimming.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/20/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
