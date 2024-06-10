import SwiftUI

struct StudyPlan: Codable {
    var daysUntilExam: Int
    var daysOfWeekToAvoid: [String]
    var minutesOfStudyTimeAvailable: Int
}

struct StudyPlanInputView: View {
    @Binding  var daysUntilExam: Int
    @Binding  var daysOfWeekToAvoid: [String]
    @Binding  var minutesOfStudyTimeAvailable: Int
    
    @State private var alreadyNavigated: Bool = UserDefaults.standard.bool(forKey: "AlreadyNavigated")
    
//    init() {
//        // Retrieve study plan data from UserDefaults
//        let savedDaysUntilExam = UserDefaults.standard.integer(forKey: "DaysUntilExam")
//        let savedDaysOfWeekToAvoid = UserDefaults.standard.array(forKey: "DaysOfWeekToAvoid") as? [String] ?? []
//        let savedMinutesOfStudyTimeAvailable = UserDefaults.standard.integer(forKey: "MinutesOfStudyTimeAvailable")
//        
//        _daysUntilExam = State(initialValue: savedDaysUntilExam)
//        _daysOfWeekToAvoid = State(initialValue: savedDaysOfWeekToAvoid)
//        _minutesOfStudyTimeAvailable = State(initialValue: savedMinutesOfStudyTimeAvailable)
//    }
//    
    var body: some View {

             NavigationView{
                 
                VStack {
                    Spacer()
                    ZStack {
                        
                        Color.teal
                        Form {
                            Section(header: Text("Study Plan").font(Font.custom("AvenirNextCondensed-Medium", size: 26))
                                .foregroundColor(.white)) {
                                    Stepper(value: $daysUntilExam, in: 1...20) {
                                        Text("- Days until exam  \(daysUntilExam)")
                                            .font(Font.custom("AvenirNextCondensed-Medium", size: 35))
                                            .foregroundColor(.white)
                                    }
                                    .onAppear {
                                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                                    }
                                    .onChange(of: daysUntilExam) { _ in
                                        saveStudyPlan()
                                    }
                                    
                                    
                                    Picker("- Minutes available to study every day ", selection: $minutesOfStudyTimeAvailable) {
                                        Text("10").tag(10)
                                        Text("15").tag(15)
                                        Text("30").tag(30)
                                        Text("45").tag(45)
                                        Text("60").tag(60)
                                    }
                                    .font(Font.custom("AvenirNextCondensed-Medium", size: 35))
                                    .foregroundColor(.white)
                                    .onChange(of: minutesOfStudyTimeAvailable) { _ in
                                        saveStudyPlan()
                                    }
                                    
                                    Spacer()
                                    
                                   
                                    Text("Enter the days until your final exam and the minutes you have to spare every day to put towards studying!")
                                        .font(Font.custom("AvenirNextCondensed-Medium", size: 20))
                                        .foregroundColor(.teal)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: 400, height: 200)
                                        .background(Rectangle().fill(Color.white).cornerRadius(15.0))
                                }
                            
                            .navigationBarBackButtonHidden(true)
                            
                            
                            
                        }
                        
                        
                    }
                    Spacer()
                    
                  
                }
           
            }
            .onDisappear {
                // Set alreadyNavigated to true when navigating away from StudyPlanInputView
                UserDefaults.standard.set(true, forKey: "AlreadyNavigated")
            }
        }
    
    
    private func saveStudyPlan() {
        UserDefaults.standard.set(daysUntilExam, forKey: "DaysUntilExam")
        UserDefaults.standard.set(daysOfWeekToAvoid, forKey: "DaysOfWeekToAvoid")
        UserDefaults.standard.set(minutesOfStudyTimeAvailable, forKey: "MinutesOfStudyTimeAvailable")
    }
}

