// UIFile responsável pela splash art

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive: Bool = false;
    
    var body: some View {
        
        ZStack {
            if self.isActive {
                HomeScreen()
                    .environmentObject(HabitStore()).environmentObject(ProgressStore())
            } else {
                VStack {
                    Image("HabitJourney")
                        .padding(.bottom, 20);
                    
                    Text("HabitJourney")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 20);
                    
                    Text("Uma jornada de mil milhas começa com um único passo")
                        .font(.callout);
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
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

