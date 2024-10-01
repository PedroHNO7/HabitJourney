 // Documento responsável pela classe de Usuários
import SwiftUI

struct User: Identifiable {
    
    var id: String
    var name: String
    var email: String
    var password: String

    init(id: String = UUID().uuidString, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
