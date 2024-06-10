import SwiftUI
import Foundation

struct ContentView: View {

  @Binding var daysUntilExam: Int 
    //I wanna get rid of the free day 
   @Binding  var daysOfWeekToAvoid: [String]
   @Binding var minutesOfStudyTimeAvailable: Int
      @State private var studyTimeProgress: Int = 0 
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let examDate: Date
    
    var daysUntilString: String {
        let calendar = Calendar.current
        let days = (calendar.dateComponents([.day], from: Date(), to: examDate).day ?? 0) + 1
        return String(days)
    }
    
    var body: some View {
        
        
        
        NavigationView{
            ZStack{
                
                
                //tabs
                
                
                Color.teal
                
                VStack{
                    Spacer()
                       

                           
                    
                    
                    
                    
                    
                    
                    
                    Text("Days Until Exam:")
                        .font(Font.custom("AvenirNextCondensed-Medium", size: 40))
                        .foregroundColor(.white)
                    Text(daysUntilString)
                        .font(Font.custom("AvenirNextCondensed-Medium", size: 100))
                        .foregroundColor(.white)
                    Text("Study Today for \(Int(minutesOfStudyTimeAvailable)) minutes")
                        .font(Font.custom("AvenirNextCondensed-Medium", size: 50))
                        .foregroundColor(.white)
                    Spacer()
                    
                    Text("Set up a study plan in Study Plan, calculate what you need for your final grade in Final Grade, and use the Timer to keep track of daily study time!")
                        .font(Font.custom("AvenirNextCondensed-Medium", size: 25))
                        .foregroundColor(.teal)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 400, height: 150)
                        .background(Rectangle().fill(Color.white).cornerRadius(15.0))
                    Spacer()

                    
                    Spacer()
                    
                   
                    NavigationLink(destination: CalcView()) {
                        
                        Text("Final Grade")
                            .font(Font.custom("AvenirNextCondensed-Medium", size: 26))
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 7))
                        
                    }
                    
                    
                    Spacer()
                    NavigationLink(destination: StudyPlanInputView(daysUntilExam: $daysUntilExam, daysOfWeekToAvoid: $daysOfWeekToAvoid, minutesOfStudyTimeAvailable: $minutesOfStudyTimeAvailable)) {
                        
                        Text("Study Plan")
                            .font(Font.custom("AvenirNextCondensed-Medium", size: 26))
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 7))
                        
                    }
                    
                    .padding(.bottom, 21) 
                    
                    NavigationLink(destination: TimerView(daysUntilExam: self.$daysUntilExam, daysOfWeekToAvoid: self.$daysOfWeekToAvoid, minutesOfStudyTimeAvailable: self.$minutesOfStudyTimeAvailable)) {
                        
                        Text("Timer")
                            .font(Font.custom("AvenirNextCondensed-Medium", size: 26))
                            .foregroundColor(.white)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 7))
                        
                    }
                    .padding(.bottom, 30) 
                    
                    
                    
                    
                }
            }
            
            
            
            
            
            
        }
        
        
        
        
        .onAppear {
            let calendar = Calendar.current
            let midnight = calendar.startOfDay(for: Date())
            let tomorrowMidnight = calendar.date(byAdding: .day, value: 1, to: midnight)!
            let timeInterval = tomorrowMidnight.timeIntervalSince(Date())
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
                // Reset minutesOfStudyTimeAvailable to its original value
                self.minutesOfStudyTimeAvailable = 60
                
                
                
                let updatedMinutesOfStudyTimeAvailable = minutesOfStudyTimeAvailable - studyTimeProgress
                
                // Display the updated minutesOfStudyTimeAvailable
                Text("Minutes of Study Time Available: \(updatedMinutesOfStudyTimeAvailable)")
                    .font(Font.custom("AvenirNextCondensed-Medium", size: 20))
                    .foregroundColor(.white)
                
                // Pass the updated minutesOfStudyTimeAvailable as a binding to TimerView
                
                NavigationLink(destination: TimerView(daysUntilExam: self.$daysUntilExam, daysOfWeekToAvoid: self.$daysOfWeekToAvoid, minutesOfStudyTimeAvailable: self.$minutesOfStudyTimeAvailable)) {
                    
                }
            }
            
        }   
        
    }
}



