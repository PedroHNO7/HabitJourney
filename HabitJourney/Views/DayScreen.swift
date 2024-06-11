// Documento responsável peloo dia específico

import SwiftUI
import UIKit

struct DayScreen: View {
    
    
    
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                
                HStack(){
                    Text("Sunday")
                        .font(.title)
                        .bold()
                        .padding(.leading,20)
                } // HStack dia da semana
                
                
                HStack{
                    // Dia atual - TO-DO: Mudar o dia com dia atual em si
                    Text("12/06")
                        .font(.title)
                        .padding(.leading, 20);
                    
                    
                    Spacer();
                    
                        // Botão personalizado
                        NavigationLink(){
                            AddScreen()
                        } label:{
                            Image("Button")
                        }
                } //HStack data e botão
                
                HStack{
                    

                } // Aqui sera o código de barra
                
            } //VStack
            
        } //NavigationView
    }
}




func loadView() {
    
}

#Preview {
    DayScreen()
}
