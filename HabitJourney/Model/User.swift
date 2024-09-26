// Documento responsável pela classe de Usuários
import SwiftUI

struct User: Identifiable {
    var ID: String
    var name: String
    var email: String
    var password: String

    init(ID: String = UUID().uuidString, name: String, email: String, password: String) {
        self.ID = ID
        self.name = name
        self.email = email
        self.password = password
    }
}