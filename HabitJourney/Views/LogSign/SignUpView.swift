import SwiftUI

struct SignUpView: View {
    
    let db = DBManager()
    
    @State var userName: String
    @State var userEmail: String
    @State var userPassword: String
    
    
    @State var show: Bool = false
    
    @State var nameField: FieldModel = FieldModel(value: "", fieldType: .name)
    @State var emailField: FieldModel = FieldModel(value: "", fieldType: .email)
    @State var passwordField: FieldModel = FieldModel(value: "", fieldType: .password)
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            
            Image(systemName: "pencil")
            Text("Cadastro").padding(.bottom)
            
            
            
            CustomTextField(fieldModel: $nameField)
                .onSubmit {
                    nameField.onSubmitError()
                }.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            
            CustomTextField(fieldModel: $emailField)
                .onSubmit {
                    emailField.onSubmitError()
                }.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
         
           
            CustomTextField(fieldModel: $passwordField)
                .onSubmit {
                    emailField.onSubmitError()
                }.autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            Button("Cadastrar"){
                
                var name = nameField.onValidate()
                
                var email = emailField.onValidate()
               
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
    SignUpView(userName: "", userEmail: "", userPassword: "")
}

