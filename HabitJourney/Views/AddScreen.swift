//
//  AddScreen.swift
//  HabitJourney
//
//  Created by coltec on 04/06/24.
//

import SwiftUI

struct AddScreen: View {
    
    
    
    @State private var inputString:String =  "";
    
    var body: some View {
        NavigationView {
            VStack {
                Text("12/06").font(.title).bold();
                Text("Create new habit").font(.subheadline);
                
                Text("Qual é o hábito deve ser registrado?");
                TextField("Exercitar, ler livros, etc...", text: $inputString)
                    .frame(width: 350, height: 50)
                    .textFieldStyle(.roundedBorder)
                    .border(Color(("AppColor/MarginSecondary")), width: 5)
                    .multilineTextAlignment(TextAlignment.center);
                    
                    
                
                Text("Qual a recorrência?");
                
                HStack {
                    Image("");
                    Text("Domingo")
                };
                
                HStack {
                    Image("");
                    Text("Segunda-feira")
                };
                
                    
            } // VStack MAIN
        }
    }
}

#Preview {
    AddScreen()
}
