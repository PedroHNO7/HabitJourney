// Tela Home - Responsável por redirecionar o usuário para as demais telas

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            // Cabeçalho com a imagem e o texto
            HStack {
                Image("HabitJourney");
                Text("HabitJourney")
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                    .foregroundColor(Color("AppColor/TaskMain"))
                
            } // HStack - CABEÇALHO
            
            HStack {
                // Dia atual - TO-DO: Mudar o dia com dia atual em si
                Text("12/06")
                    .font(.title)
                    .padding(.leading, 20);
                
                Spacer();
                
                // Botão personalizado
                Button(action: {
                    // TO-DO: Adicionar funcionalidade para o botão redirecionar para TelaHábitos
                }) {
                    HStack {
                        // TO-DO: Mudar o ícone e as cores do botão
                        Image(systemName: "plus");
                        Text("ADD");
                    }
                    .padding()
                    .background(Color.clear) // Define o fundo como transparente
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 2)
                    );
                } // Button
            } // HStack - DIA E BOTÃO
            .padding(.trailing, 20);
            
            
                HStack {
                    Text("D S T Q Q S S")
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

