import SwiftUI

struct HomeScreen: View {
    @State private var currentDate = Date()
    
    @EnvironmentObject var habitStore: HabitStore
    @EnvironmentObject var progressStore: ProgressStore

    @Binding var userID: String
    
    var body: some View {
        NavigationView {
            VStack {
                headerSection
                dateSection
                dayGridSection
            }
            .padding()
        }
    }
    
    private var headerSection: some View {
            HStack {
                Image("HabitJourney")
                Text("HabitJourney")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("AppColor/TaskMain"))
            }
            .padding(.bottom, 30)
        }
        
        private var dateSection: some View {
            HStack {
                Text(dateFormatter.string(from: currentDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)

                Spacer()
            }
            .padding(.trailing, 20)
        }
        
        private var dayGridSection: some View {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(30), spacing: 20), count: 7)) {
                // Iniciais dos dias da semana
                ForEach(0..<7) { index in
                    Text(weekdayInitial(for: index))
                        .font(.system(size: 20))
                        .bold()
                        .padding(8)
                }

                // Calcular o índice correto para o dia atual
                let calendar = Calendar.current
                let weekdayOffset = currentWeekdayOffset()

                ForEach(0..<weekdayOffset, id: \.self) { _ in
                    Color.clear.frame(width: 45, height: 45)
                }

                // Dias do mês
                ForEach(0..<28) { index in
                    let date = calendar.date(byAdding: .day, value: index, to: currentDate)!
                    let isToday = calendar.isDate(date, inSameDayAs: currentDate)

                    NavigationLink(destination: DayScreen(userID: $userID, selectedDate: date).environmentObject(habitStore)) {
                        Text(dayFormatter.string(from: date)).bold()
                            .frame(width: 45, height: 45)
                            .background(progressColor(for: progressStore.percent))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            } // LazyVGrid
        }

        // Calcula os espaços em branco baseado no dia
        func currentWeekdayOffset() -> Int {
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: currentDate)
            return (weekday - 1) % 7
        }

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM"
            return formatter
        }()

        let dayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter
        }()

        func weekdayInitial(for index: Int) -> String {
            switch index {
            case 0: return "D"
            case 1: return "S"
            case 2: return "T"
            case 3: return "Q"
            case 4: return "Q"
            case 5: return "S"
            case 6: return "S"
            default: return "ERROR"
            }
        }

        func progressColor(for percent: CGFloat) -> Color {
            switch percent {
            case 0..<20: return Color("AppColor/TaskMain20")
            case 20..<40: return Color("AppColor/TaskMain35")
            case 40..<60: return Color("AppColor/TaskMain55")
            case 60..<80: return Color("AppColor/TaskMain75")
            default: return Color("AppColor/TaskMain")
            }
        }
    }
