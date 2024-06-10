import SwiftUI
struct TimerView: View {
    @State private var timeInput = ""
    @State private var remainingTime = 0
    @State private var timer: Timer?
    @State private var isRunning = false
    @State private var showAlert = false
    @State private var showWarning = false
    @Binding var daysUntilExam: Int
    //I wanna get rif of the free day 
    @Binding  var daysOfWeekToAvoid: [String]
    @Binding var minutesOfStudyTimeAvailable: Int
    @State private var isAnimating = false
      @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    //have data persist when app is closed for al 
    
    var body: some View {
        ZStack{
            Color.teal
            
            VStack {
                
                
                
                Text("Study Timer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                Text("Minutes of Reccomended Study Time")
                    .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                    .foregroundColor(.white)
                Text("\(minutesOfStudyTimeAvailable)")
                    .font(Font.custom("AvenirNextCondensed-Medium", size: 100))
                    .foregroundColor(.white)
                
                
                Image(systemName: "book.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(360))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                    .onAppear {
                        isAnimating = true
                    }
                
                
                Text(timeRemaining)
                    .font(.system(size: 50))
                    .padding(.bottom, 20)
                
                TextField("Enter time in minutes", text: $timeInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .keyboardType(.numberPad)
                
                if showWarning {
                    Text("Please enter a whole number")
                        .font(Font.custom("AvenirNextCondensed-Medium", size: 26))
                        .foregroundColor(.pink)
                        .padding(.top, 5)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    showWarning = false
                                }
                            }
                        }
                    
                    
                    
                    
                    
                    
                }
                Text("Use the timer to subtract daily study time!")
                    .font(Font.custom("AvenirNextCondensed-Medium", size: 20))
                    .foregroundColor(.teal)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 200, height: 100)
                    .background(Rectangle().fill(Color.white).cornerRadius(15.0))

                
                
                Spacer()
                
                HStack {
                    
                    
                    
                    
                    
                    
                    
                    Button(action: startTimer) {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                    }
                    
                    
                    
                    
                    Button(action: resetTimer) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.orange)
                    }
                    .padding(.horizontal)
                    
                    
                    
                    .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                        ToolbarItem (placement: .navigationBarLeading) {
                            
                            Button(action: {
                                
                                presentationMode.wrappedValue
                                    .dismiss()
                                
                            }, label: {
                                Image(systemName: "house")
                                    .foregroundColor(.white)
                                Text("Home")
                                    .foregroundStyle(Color.teal)
                                
                            })
                            
                            
                            
                            
                            
                        }
                    })
                    
                }
                .padding(.bottom, 40)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Study Session complete!"), message: Text("Your timer has reached zero!"), dismissButton: .default(Text("OK")))
        }
    }
    
    var timeRemaining: String {
        let hours = remainingTime / 3600
        let minutes = (remainingTime % 3600) / 60
        let seconds = remainingTime % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func startTimer() {
        guard let minutes = Int(timeInput) else {
            showWarning = true
            return
            
            
            
        }
        
        if isRunning {
            timer?.invalidate()
            isRunning = false
        } else {
            remainingTime = minutes * 60
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    timer?.invalidate()
                    minutesOfStudyTimeAvailable -= Int(timeInput) ?? 0 // Deduct study time
                    showAlert = true
                    UserDefaults.standard.setValue(minutesOfStudyTimeAvailable, forKey: "MinutesOfStudyTimeAvailable")
                    
                         
                    
                }
            }
            isRunning = true
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        isRunning = false
        remainingTime = 0
        timeInput = ""
    }
    
    func resetTimer() {
        timeInput = ""
        remainingTime = 0
        showWarning = false
        timer?.invalidate()
        isRunning = false
    }
    
//    func getTimerData() -> Int {
//        let savedMinutesOfStudyTimeAvailable =  UserDefaults.standard.integer(forKey: "MinutesOfStudyTimeAvailable")
//        return savedMinutesOfStudyTimeAvailable ?? 0   
//    }
    
    
    
    
}
