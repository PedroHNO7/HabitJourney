import SwiftUI

struct SignUpView: View {
    
    let db = DBManager()
    
    @State var userName: String
    @State var userEmail: String
    @State var userPassword: String

    @Environment(\.dismiss) var dismiss
    
    @State var show: Bool = false
    
    @State var nameField: FieldModel = FieldModel(value: "", fieldType: .name)
    @State var emailField: FieldModel = FieldModel(value: "", fieldType: .email)
    @State var passwordField: FieldModel = FieldModel(value: "", fieldType: .password)
    
    var body: some View {
        ZStack{
            
            Image("sign").resizable().ignoresSafeArea()
            
            VStack {
                
                CustomTextField(fieldModel: $nameField).padding(.top, 300).foregroundColor(.white)
                    .onSubmit {
                        nameField.onSubmitError()
                    }
                
                CustomTextField(fieldModel: $emailField).foregroundColor(.white)
                    .onSubmit {
                        emailField.onSubmitError()
                    }.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                CustomTextField(fieldModel: $passwordField).foregroundColor(.white)
                    .onSubmit {
                        emailField.onSubmitError()
                    }.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                Button("Cadastrar"){
                    
                    let name = nameField.onValidate()
                    
                    let email = emailField.onValidate()
                    
                    let password = passwordField.onValidate()
                    
                    if name && email && password {
                        let user = User(name: nameField.value, email: emailField.value, password: passwordField.value)
                        
                        if (db.insertUser(user: user)){
                            show = true
                            
                            dismiss()
                        }
                    } else {
                        return
                    }
                    
                }.buttonStyle(.borderedProminent)
                    .padding()
            }
            .padding()
            .alert(isPresented: $show) {
                Alert( title: Text("Sucesso"),
                       message: Text("\(userName) Inserido com sucessso"),
                       dismissButton: .default(Text("Ok"))
                )
            }}
    }
}

#Preview {
    SignUpView(userName: "", userEmail: "", userPassword: "")
}

