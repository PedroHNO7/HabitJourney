import SwiftUI

struct SignUpView: View {
    
    let db = DBManager()
    
    @State var userName: String
    @State var userEmail: String
    @State var userPassword: String
    @State var userAddress: String
    
    
    @State var show: Bool = false
    
    @State var nameField: FieldModel = FieldModel(value: "", fieldType: .name)
    @State var emailField: FieldModel = FieldModel(value: "", fieldType: .email)
    @State var addressField: FieldModel = FieldModel(value: "", fieldType: .address)
    @State var passwordField: FieldModel = FieldModel(value: "", fieldType: .password)
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            
            Image(systemName: "pencil")
            Text("Cadastro").padding(.bottom)
            
            
            
            CustomTextField(fieldModel: $nameField)
                .onSubmit {
                    nameField.onSubmitError()
                }
            
            
            CustomTextField(fieldModel: $emailField)
                .onSubmit {
                    emailField.onSubmitError()
                }
            
            CustomTextField(fieldModel: $addressField)
                .onSubmit {
                    addressField.onSubmitError()
                }
         
           
            CustomTextField(fieldModel: $passwordField)
                .onSubmit {
                    emailField.onSubmitError()
                }
            
            Button("Cadastrar"){
                
                var name = nameField.onValidate()
                
                var email = emailField.onValidate()
                
                var address = addressField.onValidate()
               
                var password = passwordField.onValidate()
            
                    
                let user = User(name: nameField.value, email: emailField.value, password: passwordField.value)
                    
                if (db.insertUser(user: user)){
                    show = true
                }
                
                
                
               
                   
            }.buttonStyle(.borderedProminent)
                .padding()
        }
        .padding()
        .alert(isPresented: $show) {
            Alert( title: Text("Sucesso"),
                   message: Text("\(userName) inserido com sucessso"),
                   dismissButton: .default(Text("Ok"))
                   )
        }
    }
        
    
}

#Preview {
    SignUpView(userName: "", userEmail: "", userPassword: "", userAddress: "")
}

