
import SwiftUI

struct CustomTextField: View {
    
    var fieldModel: Binding<FieldModel>
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(fieldModel.fieldType.wrappedValue.placeHolder)
            VStack{
                if fieldModel.fieldType.wrappedValue == FieldType.email || fieldModel.fieldType.wrappedValue == FieldType.name || fieldModel.fieldType.wrappedValue == FieldType.address{
                    TextField("", text: fieldModel.value)
                        .frame(width: 320, height: 48)
                        .textFieldStyle(PlainTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AppColor/MarginSecondary"), lineWidth: 5)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color("AppColor/MarginSecondary"))
                    
                
                } else {
                    SecureField("", text: fieldModel.value)
                        .frame(width: 320, height: 48)
                        .textFieldStyle(PlainTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("AppColor/MarginSecondary"), lineWidth: 5)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color("AppColor/MarginSecondary"))
                }
                
            }
            .cornerRadius(10)
            
            if let error = fieldModel.error.wrappedValue{
                Text(error)
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 0)
            }
        }
        .padding()
    }
}

