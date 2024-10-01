//
//  FieldType.swift
//  BancoDeUsuarios
//
//  Created by coltec on 17/09/24.
//

import Foundation

protocol FieldValidationProtocol{
    func validate(value: String) -> String?
}

enum FieldType: FieldValidationProtocol, Equatable{
    
    case name
    case email
    case password
    case address
    
    
    var placeHolder: String{
        switch self{
        case .name:
            return "Nome"
        case .email:
            return "E-mail"
        case .password:
            return "Senha"
        case .address:
            return "Endereço"
        }
    }
    
    func validate(value: String) -> String? {
        switch self{
        case .name:
            return nameValidate(value: value)
        case .email:
            return emailValidate(value: value)
        case .password:
            return passwordValidate(value: value)
        case .address:
            return addressValidate(value: value)
        
        }
    }
    
    private func nameValidate(value: String) -> String?{
        value.isEmpty ? "Digite seu nome" : nil
    }
    
    private func emailValidate(value: String) -> String?{
        if value.isEmpty{
            return "Digite seu e-mail"
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: value) ? nil : "Entre com um e-mail válido"
        }
    }
    
    private func passwordValidate(value: String) -> String?{
        value.isEmpty ? "Digite sua senha" : nil
    }
    
    private func addressValidate(value: String) -> String?{
        value.isEmpty ? "Digite sua endereço" : nil
    }
    
    
}

