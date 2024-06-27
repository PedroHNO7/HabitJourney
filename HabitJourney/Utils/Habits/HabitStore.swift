import SwiftUI
import Combine

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []
}
