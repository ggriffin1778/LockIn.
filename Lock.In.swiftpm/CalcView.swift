import SwiftUI


struct CalcView: View {
    let pastelPurple = Color(UIColor(red: 0.8, green: 0.7, blue: 0.9, alpha: 1.0))
    let navyBlue = Color(UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1.0))
    @State private var desiredGrade = ""
    @State private var examPercentage = ""
    @State private var currentGrade = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var isAnimating = false
    
    
    var body: some View {
        
        
        
        
        NavigationView {
            VStack {
                
                
                
                
                
                
                ZStack{
                    Color.teal
                    VStack{
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(360))
                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                            .onAppear {
                                isAnimating = true
                            }
                             .padding(.bottom, 100) 
                        
                        
                        
                        
                        Text("Calculate Desired final Grade!")
                            .font(Font.custom("AvenirNextCondensed-Medium", size: 20))
                            .foregroundColor(.teal)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 200, height: 100)
                            .background(Rectangle().fill(Color.white).cornerRadius(15.0))
                        
                        
                       
                        
                        
                        
                        
                       Text("Grade Calculator for Finals")
                            .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                            .foregroundColor(.white)
                        
                                
                                
                        
                       
                        
                        Section(header: Text("Enter Class and Exam Information")   .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                            .foregroundColor(.white)) {
                                
                                TextField("- Desired grade in percentage -", text: $desiredGrade)
                                    .keyboardType(.numberPad)
                                    .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                                    .foregroundColor(.white)
                                
                                TextField("- Percetage of grade exam is worth -", text: $examPercentage)
                                    .keyboardType(.numberPad)
                                    .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                                    .foregroundColor(.white)
                                
                                TextField("- Current grade in percentage in class -", text: $currentGrade)
                                    .keyboardType(.numberPad)
                                    .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                                    .foregroundColor(.white)
                            }
                        
                        Section {
                            Button("Calculate") {
                                calculateRequiredScore()
                            }
                            .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                            .foregroundColor(.white)
                            
                        }
                        
                        
                        Section(header: Text("Required Score")) {
                            Text("\(formattedRequiredScore())%")
                                .font(Font.custom("AvenirNextCondensed-Medium", size: 30))
                                .foregroundColor(.white)
                                .padding()
                                .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 7))
                               
                               
                        }
                       
                        
                    }
                   
                }
            }
        }
        
        //needs a spacer beforehand for some reason? and has to be at the bottom to cover the nav link back button 
        Spacer()
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
           
    
    private func calculateRequiredScore() {
        if let desired = Double(desiredGrade),
           let percentage = Double(examPercentage),
           let current = Double(currentGrade) {
            let score = max(0, (100 * desired - (100 - percentage) * current) / percentage)
            print("Required Score: \(score)")
            
            //constantss
        } else {
            print("Invalid input. Please enter valid numbers.")
        }
    }
    
    private func formattedRequiredScore() -> String {
        guard let desired = Double(desiredGrade),
              let percentage = Double(examPercentage),
              let current = Double(currentGrade) else {
            return "0.00"
        }
        
        let score = max(0, (100 * desired - (100 - percentage) * current) / percentage)
        return String(format: "%.2f", score)
    }
}


