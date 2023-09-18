//
//  Validator.swift
//  MovieMate
//
//  Created by Yasir on 18/09/23.
//

import Foundation

class Validator {
    
    static func validateEmail(_ email: String) -> String? {
        if email.isEmpty {
            return "Email cannot be empty"
        }
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: email)
        {
            return "Invalid email address"
        }
        return nil
    }
    
    static func validatePassword(_ password: String) -> String? {
        if password.isEmpty {
            return "Password cannot be empty"
        }
        if password.count < 8
        {
            return "Password must be at least 8 characters"
        }
        if containsDigit(password)
        {
            return "Password must contain at least 1 digit"
        }
        if containsLowerCase(password)
        {
            return "Password must contain at least 1 lowercase character"
        }
        if containsUpperCase(password)
        {
            return "Password must contain at least 1 uppercase character"
        }
        return nil
    }
    
    static func validateName(_ name: String) -> String? {
        
        return nil
    }
    
    static func validatePhoneNumber(_ phoneNumber: String) -> String?
    {
        if phoneNumber.isEmpty {
            return "Phone Number cannot be empty"
        }
        let set = CharacterSet(charactersIn: phoneNumber)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Phone Number must contain only digits"
        }
        
        if phoneNumber.count != 10
        {
            return "Phone Number must be 10 digits in length"
        }
        return nil
    }
    
    static func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    static func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    static func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
}
