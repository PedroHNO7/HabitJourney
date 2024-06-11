import SwiftUI

struct CheckBoxButtonWrapper: UIViewRepresentable {
    
    @Binding var isChecked: Bool
    
    func makeUIView(context: Context) -> CheckBoxButton {
        let checkbox = CheckBoxButton()
        checkbox.setup()
        return checkbox
    }
    
    func updateUIView(_ uiView: CheckBoxButton, context: Context) {
        uiView.isSelected = isChecked
    }
}
