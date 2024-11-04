
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
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("AppColor/TaskMain"), lineWidth: 4)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("AppColor/MarginMain"))
                    
                
                } else {
                    SecureField("", text: fieldModel.value)
                        .frame(width: 320, height: 48)
                        .textFieldStyle(PlainTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("AppColor/MarginMain"), lineWidth: 4)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("AppColor/MarginMain"))
                }
                
            }
            .cornerRadius(8)
            
            if let error = fieldModel.error.wrappedValue{
                Text(error)
                    .foregroundColor(Color("AppColor/TaskMain"))
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 0)
            }
        }
        .padding()
    }
}

