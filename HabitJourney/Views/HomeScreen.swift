// Tela Home - Responsável por redirecionar o usuário para as demais telas

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                // Cabeçalho com a imagem e o texto
                HStack {
                    Image("HabitJourney");
                    Text("HabitJourney")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .foregroundColor(Color("AppColor/TaskMain"));
                    
                }.padding(.bottom, 80 ) // HStack - CABEÇALHO
                
                HStack {
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
                    
                    
                } // HStack - DIA E BOTÃO
                .padding(.trailing, 20);
                
                
                    HStack {
                        Text("D")
                            .padding(12)
                            .font(.system(size: 20));
                        Text("S")
                            .padding(12)
                            .font(.system(size: 20));
                        
                        Text("T")
                            .padding(12)
                            .font(.system(size: 20));
                        
                        Text("Q")
                            .padding(12)
                            .font(.system(size: 20));
                        
                        Text("Q")
                            .padding(12)
                            .font(.system(size: 20));
                        
                        Text("S")
                            .padding(12)
                            .font(.system(size: 20));
                        
                        Text("S")
                            .padding(12)
                            .font(.system(size: 20));
                        
                        
                    } // HStack - DIAS DA SEMANA
                
                VStack {
                    Image("emptyTask").padding(.top, 30);
                    Text("No habits created yet.\nGet started and make the first step")
                            .multilineTextAlignment(.center)
                            .padding(.top, 30)
                            .font(.system(size: 20))
                            .bold();
                    
                } // VStack - IMAGEM E TEXTO
            }
        }
    }
}

#Preview {
    HomeScreen()
}
