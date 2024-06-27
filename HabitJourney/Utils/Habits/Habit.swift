// Documento responsável pela classe de Hábitos

import SwiftUI

struct Habit: Identifiable {
    var id = UUID()
    var name: String
    
    // Responsável pela recorrencia (0 = Domingo, 6 = Sábado)
    var recurrence: [Int]
}
