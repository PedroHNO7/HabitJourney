// Documento responsável pela classe de Hábitos

import SwiftUI

struct Habit: Identifiable {
    var id: String
    var userID: String
    var title: String
    var recurrence: Int32

    init(id: String = UUID().uuidString, userID: String, title: String, recurrence: Int32) {
        self.id = id
        self.userID = userID
        self.title = title
        self.recurrence = recurrence
    }
}
