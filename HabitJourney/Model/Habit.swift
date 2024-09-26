// Documento responsável pela classe de Hábitos

import SwiftUI

struct Habit: Identifiable {
    var ID: String
    var userID: String
    var title: String
    var recurrence: [Bool]
    
    init(ID: String = UUID().uuidString, userID: String, title: String, recurrence: [Bool]) {
        self.ID = ID
        self.userID = userID
        self.title = title
        self.recurrence = recurrence
    }
}
