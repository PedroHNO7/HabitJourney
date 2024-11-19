import SwiftUI
import Combine

class ProgressStore: ObservableObject {
    @Published var percent: CGFloat = 0
    
    func updateProgress(habits: [Habit], checkedHabits: Set<String>) {
            let total = habits.count
            let completed = habits.filter { checkedHabits.contains($0.id) }.count
            percent = total > 0 ? CGFloat(completed) / CGFloat(total) * 100 : 0
        }
}
