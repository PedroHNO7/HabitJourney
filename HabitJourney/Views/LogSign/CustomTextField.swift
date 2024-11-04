
import SwiftUI

struct CustomTextField: View {
    
    var fieldModel: Binding<FieldModel>
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(fieldModel.fieldType.wrappedValue.placeHolder)
            VStack{
                if fieldModel.fieldType.wrappedValue == FieldType.email || fieldModel.fieldType.wrappedValue == FieldType.name || fieldModel.fieldType.wrappedValue == FieldType.address{
                    TextField("", text: fieldModel.value)
                        .frame(width: 320, height: 50)
                        .textFieldStyle(PlainTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("AppColor/MarginSecondary"), lineWidth: 5)
                        )
                        .accessibilityLabel("Insira o hábito a ser registrado")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 4)
                    
                
                } else {
                    SecureField("", text: fieldModel.value)
                        .frame(width: 320, height: 50)
                        .textFieldStyle(PlainTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("AppColor/MarginSecondary"), lineWidth: 5)
                        )
                        .accessibilityLabel("Insira o hábito a ser registrado")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 4)
                }
                
            }
            
            if let error = fieldModel.error.wrappedValue{
                Text(error)
                    .foregroundColor(Color("AppColor/MarginLogo"))
                    .font(.system(size: 16))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 0)
            }
        }
        .padding()
    }
}

