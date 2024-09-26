// Documento responsável pela visualização da lista de hábitos

import SwiftUI
import Combine

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []
}

// Manipulação da lista com dados do Banco de Dados

// class HabitStore: ObservableObject {
//     @Published var habits: [Habit] = []
//     private var dbManager = DBManager()
    
//     func loadHabits(for userID: String) {
//         self.habits = dbManager.getHabitsByUserID(userID: userID)
//     }
// }