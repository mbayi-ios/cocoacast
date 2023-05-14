//
//  String+Helpers.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 09/10/2021.
//

import Foundation

extension String {

    private static let emailPredicate: NSPredicate = {
        let username = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}[A-Za-z]{2,8}"
        return NSPredicate(format: "SELF MATCHES %@", username + "@" + domain)
    }()

    var isEmail: Bool {
        Self.emailPredicate.evaluate(with: self)
    }

}
