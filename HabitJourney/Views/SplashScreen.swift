// UIFile responsável pela splash art -- TO-DO: Trocar esse arquivo pelo *Launch Screen*

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive: Bool = false;
    
    var body: some View {
        
        ZStack {
            if self.isActive {
                HomeScreen()
            } else {
                VStack {
                    Image("HabitJourney")
                        .padding(.bottom, 20);
                    
                    Text("HabitJourney")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .padding(.bottom, 20);
                    
                    Text("Uma jornada de mil milhas começa com um único passo")
                        .font(.callout);
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation{
                            self.isActive = true;
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
