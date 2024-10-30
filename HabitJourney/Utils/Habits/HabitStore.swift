// Documento responsável pela visualização da lista de hábitos

import SwiftUI
import Combine

 class HabitStore: ObservableObject {
     @Published var habits: [Habit] = []
     var dbManager = DBManager()
    
     func loadHabits(for id: String) {
         self.habits = dbManager.getAllHabits()
     }
 }
