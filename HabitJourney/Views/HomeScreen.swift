import SwiftUI

struct HomeScreen: View {
    @State private var currentDate = Date()
    
    @EnvironmentObject var habitStore: HabitStore
    @EnvironmentObject var progressStore: ProgressStore
    
    @ObservedObject var authService: AuthService = AuthService()
    
    @State private var showSignUpView = false
    @State private var isUserLoggedIn = false
    
    @Environment(\.dismiss) var dismiss

    @Binding var userID: String
    
    var body: some View {
        NavigationView {
            VStack {
                headerSection
                dateSection
                dayGridSection
            }.onAppear{
                isUserLoggedIn = authService.isUserLoggedIn()
            }
        }
    }
    
    private var headerSection: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Button{
                     authService.googleSignOut()
                     isUserLoggedIn = false
                   
                    showSignUpView = true
                    
                } label: {
                    HStack{
                        Image(systemName: "rectangle.portrait.and.arrow.right").resizable().frame(width: 40, height: 40).tint(Color("AppColor/TaskMain"))
                        Text("Sair").font(.subheadline)
                            .bold()
                            .foregroundColor(Color("AppColor/TaskMain"))
                    }
                }
            }.padding(.bottom, 120)
        
            HStack {
                Image("HabitJourney")
                Text("HabitJourney")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("AppColor/TaskMain"))
            }
            .padding(.bottom, 30)
        }
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
                            .background(progressColor(for: progressForDate(date)))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            } // LazyVGrid
        }
    
    // Calcula o progresso da data especifica
    func progressForDate(_ date: Date) -> CGFloat {
        let habitsForDate = habitStore.habits.filter { habit in
            let weekday = Calendar.current.component(.weekday, from: date) - 1
            if habit.recurrence.count > weekday {
                let isActiveForToday = habit.recurrence[habit.recurrence.index(habit.recurrence.startIndex, offsetBy: weekday)] == "1"
                return isActiveForToday
            }
            return false
        }

        // Recuperando do UserDefault
        let checkedHabits = loadCheckedHabits(for: date)

        let completedCount = habitsForDate.filter { checkedHabits.contains($0.id) }.count
        let totalCount = habitsForDate.count
        
        return totalCount > 0 ? CGFloat(completedCount) / CGFloat(totalCount) * 100 : 0
    }

    // Carrega hábitos marcados de uma data especifica
    func loadCheckedHabits(for date: Date) -> Set<String> {
        let key = dateFormatter.string(from: date)
        if let checkedHabitsData = UserDefaults.standard.data(forKey: key),
           let loadedCheckedHabits = try? JSONDecoder().decode([String].self, from: checkedHabitsData) {
            return Set(loadedCheckedHabits)
        }
        return Set<String>()
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
