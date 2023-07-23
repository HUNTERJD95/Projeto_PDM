import SwiftUI

struct ScheduleItem: Identifiable {
    let id = UUID()
    let day: String
    let times: [String]
}

struct ScheduleView: View {
    @State var selectedTime: String?
    @Environment(\.presentationMode) var presentationMode
    
    var scheduleItems: [ScheduleItem] = [
        ScheduleItem(day: "Segunda-feira", times: ["9:00 - 10:30", "14:00 - 15:30"]),
        ScheduleItem(day: "Terça-feira", times: ["10:00 - 11:30", "16:00 - 17:30"]),
        ScheduleItem(day: "Quarta-feira", times: ["09:00 - 10:00", "14:00 - 15:30"]),
        ScheduleItem(day: "Quinta-feira", times: ["11:00 - 12:30", "19:00 - 20:00"]),
        ScheduleItem(day: "Sexta-feira", times: ["07:00 - 08:30", "15:00 - 16:30"]),
        ScheduleItem(day: "Sábado", times: ["10:00 - 11:30"]),
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                
                VStack {
                    Text("Horários")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    List {
                        ForEach(scheduleItems) { item in
                            Section(header: Text(item.day).font(.title).bold().frame(maxWidth: .infinity).padding(.vertical, 8)) {
                                
                                ForEach(item.times, id: \.self) { time in
                                    HStack {
                                        Spacer()
                                        Text(time)
                                            .font(.title2)
                                            .padding(.vertical, 4)
                                        Spacer()
                                        if selectedTime == time {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedTime = time
                                    }
                                }
                            }
                        }
                    }
                    
                    Button("Marcar Aula") {
                        if let selectedTime = selectedTime {
                            // TODO send to DB if enough time :/
                            
                            print("Aula marcada para: \(selectedTime)")
                        } else {
                            print("Selecione um horário antes de marcar a aula.")
                        }
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    Button("Voltar") {
                        presentationMode.wrappedValue.dismiss() // Dismiss the current view
                    }
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .background(Color.clear)
            }
            .navigationBarHidden(true)
        }
    }
}

struct Horarios_e_Marcacao_Aulas: View {
    var body: some View {
        ScheduleView()
    }
}

struct Horarios_e_Marcacao_Aulas_Previews: PreviewProvider {
    static var previews: some View {
        Horarios_e_Marcacao_Aulas()
    }
}
