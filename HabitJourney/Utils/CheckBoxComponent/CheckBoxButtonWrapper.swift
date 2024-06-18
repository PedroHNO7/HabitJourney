import SwiftUI

struct CheckBoxButtonWrapper: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(isChecked ? .blue : .gray)
        }
    }
}
