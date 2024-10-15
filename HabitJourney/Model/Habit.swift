// Documento responsável pela classe de Hábitos

import SwiftUI

struct Habit: Identifiable {
    var id: String
    var userID: String
    var title: String
    var recurrence: String
    
    init(id: String = UUID().uuidString, userID: String, title: String, recurrence: String) {
        self.id = id
        self.userID = userID
        self.title = title
        self.recurrence = recurrence
    }
}

