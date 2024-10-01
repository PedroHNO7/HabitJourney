
import SwiftUI

struct CustomTextField: View {
    
    var fieldModel: Binding<FieldModel>
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(fieldModel.fieldType.wrappedValue.placeHolder)
            VStack{
                if fieldModel.fieldType.wrappedValue == FieldType.email || fieldModel.fieldType.wrappedValue == FieldType.name || fieldModel.fieldType.wrappedValue == FieldType.address{
                    TextField("", text: fieldModel.value)
                        .padding(.horizontal, 8)
                    
                
                } else {
                    SecureField("", text: fieldModel.value)
                        .padding(.horizontal, 8)
                }
                
            }
            .background(Color.accentColor.opacity(0.2))
            .cornerRadius(10)
            
            if let error = fieldModel.error.wrappedValue{
                Text(error)
                    .foregroundColor(.red)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 0)
            }
        }
        .padding()
    }
}

