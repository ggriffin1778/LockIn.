import SwiftUI
import Foundation

struct SplashScreenView: View {
    let pastelPurple = Color(UIColor(red: 0.8, green: 0.7, blue: 0.9, alpha: 1.0))
    let navyBlue = Color(UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1.0))
    @State var daysUntilExam = 10 
    //I wanna get rid of the free day 
    @State  var daysOfWeekToAvoid: [String] = []
    @State var minutesOfStudyTimeAvailable = 0
    @State private var isActive = false
    @State private var size = 0.8
    @State private var examDate: Date
    @State private var opacity = 0.5
    init() {
        // Retrieve study plan data from UserDefaults
        let savedDaysUntilExam = UserDefaults.standard.integer(forKey: Keys.daysUntilExam.rawValue)
        let savedDaysOfWeekToAvoid = UserDefaults.standard.array(forKey: Keys.daysOfWeekToAvoid.rawValue) as? [String] ?? []
        let savedMinutesOfStudyTimeAvailable = UserDefaults.standard.integer(forKey: Keys.minutesOfStudyTimeAvailable.rawValue)
        let examDateTimeInterval = UserDefaults.standard.double(forKey: Keys.examDate.rawValue)
        let examDate: Date
        if examDateTimeInterval == 0 {
            let calendar = Calendar.current
            examDate = calendar.date(byAdding: .day, value: 14, to: Date()) ?? Date()       
        } else {
            examDate = Date(timeIntervalSince1970: examDateTimeInterval)
        }
        
        _daysUntilExam = State(initialValue: savedDaysUntilExam)
        _daysOfWeekToAvoid = State(initialValue: savedDaysOfWeekToAvoid)
        _minutesOfStudyTimeAvailable = State(initialValue: savedMinutesOfStudyTimeAvailable)
    
            _examDate = State(initialValue: examDate)
    }
    
    var body: some View {
        if isActive {
            ContentView(daysUntilExam: $daysUntilExam, daysOfWeekToAvoid: $daysOfWeekToAvoid, minutesOfStudyTimeAvailable: $minutesOfStudyTimeAvailable, examDate: examDate)
                .onChange(of: daysUntilExam) { newValue in 
                    let calendar = Calendar.current
                    guard let examDate = calendar.date(byAdding: .day, value: newValue, to: Date()) else { return }
                    self.examDate = examDate
                    UserDefaults.standard.set(examDate.timeIntervalSince1970, forKey: Keys.examDate.rawValue) 
                }
        } else{
            
        ZStack{
            
           Color.teal
            
            VStack {
                VStack{
                    Image(systemName: "lock.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.black)
                    
                    Text("Lock In")
                        .font(Font.custom("AvenirNextCondensed-Medium", size: 26))
                        .foregroundColor(.white)
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    withAnimation{
                      self.isActive = true   
                    }
                    
            }
            } 
            
        }
            
    } 
    
}
