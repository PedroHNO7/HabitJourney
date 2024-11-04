import Foundation

protocol FieldValidationProtocol{
    func validate(value: String) -> String?
}

enum FieldType: FieldValidationProtocol, Equatable{
    
    case name
    case email
    case password
    case habit
    
    
    var placeHolder: String{
        switch self{
        case .name:
            return "Nome"
        case .email:
            return "E-mail"
        case .password:
            return "Senha"
        case .habit:
            return ""
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
        case .habit:
            return habitValidate(value: value)
        
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
    
    private func habitValidate(value: String) -> String?{
        value.isEmpty ? "Digite o hábito" : nil
    }
    
    
}

