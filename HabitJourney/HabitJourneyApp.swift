import SwiftUI

@main
struct HabitJourneyApp: App {
    @StateObject private var habitStore = HabitStore()

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(habitStore)
        }
    }
}
