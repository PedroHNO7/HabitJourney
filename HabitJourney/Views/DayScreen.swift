// Documento responsável peloo dia específico

import SwiftUI
import UIKit

struct DayScreen: View {
    
    @State var percent: CGFloat = 0
    
    
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
                    // Barra de progresso
                    ProgressBar(width: 300, height: 20, percent: percent)
                        .animation(.spring)
                        
                    
                    Button(action: { percent = 50}, label: {
                        Text("Gerador")
                    })

                }// HStack barra de progresso
                
                
                VStack {
                    Image("emptyTask").padding(.top, 30);
                    Text("Sem hábitos criados ainda.\nComece e dê o primeiro passo.")
                            .multilineTextAlignment(.center)
                            .padding(.top, 30)
                            .font(.system(size: 20))
                            .bold();
                    
                } // VStack - IMAGEM E TEXTO
                
            } //VStack
            
        } //NavigationView
    }
}



#Preview {
    DayScreen()
}
