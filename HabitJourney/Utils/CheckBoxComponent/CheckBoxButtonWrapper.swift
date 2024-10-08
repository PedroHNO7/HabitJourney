import SwiftUI

struct CheckBoxButtonWrapper: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            Image(uiImage: UIImage(named: isChecked ? "Checked" : "Unchecked")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }
    }
}
