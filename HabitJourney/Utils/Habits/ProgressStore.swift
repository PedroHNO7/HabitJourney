import SwiftUI
import Combine

class ProgressStore: ObservableObject {
    @Published var percent: CGFloat = 0
}
