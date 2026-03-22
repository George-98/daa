import SwiftUI

struct MathsTestView: View {
    
    struct Question: Identifiable {
        let id = UUID()
        let text: String
        let answer: Double
    }
    
    @State private var question: Question?
    @State private var answers: [Double] = []
    @State private var correctAnswer: Double = 0
    
    @State private var score: Int = 0
    @State private var timeRemaining: Int = 60
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Color(red: 70/255, green: 98/255, blue: 125/255)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                // MARK: - Header (Timer + Score)
                HStack {
                    Text("⏱ \(timeRemaining)s")
                    Spacer()
                    Text("Score: \(score)")
                }
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal)
                
                if let q = question {
                    ZStack {
                        
                        Text(q.text)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                
                Spacer()
                
                // MARK: - Answers
                VStack(spacing: 15) {
                    ForEach(answers, id: \.self) { answer in
                        Button {
                            checkAnswer(answer)
                        } label: {
                            Text(format(answer))
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            startGame()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

extension MathsTestView {
    
    func startGame() {
        score = 0
        timeRemaining = 60
        generateTest()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                print("Game Over. Final Score: \(score)")
            }
        }
    }
    
    func generateTest() {
        let q = generateQuestion()
        question = q
        correctAnswer = q.answer
        
        generateAnswers()
    }
    
    func generateQuestion() -> Question {
        let a = Double.random(in: 1...10).rounded(toPlaces: 2)
        let b = Double.random(in: 1...10).rounded(toPlaces: 2)
        
        let operators = ["+", "-"]
        let op = operators.randomElement()!
        
        var result: Double = 0
        
        switch op {
        case "+":
            result = a + b
        case "-":
            result = a - b
        case "×":
            result = a * b
        case "÷":
            result = b != 0 ? a / b : a
        default:
            break
        }
        
        result = result.rounded(toPlaces: 2)
        
        return Question(
            text: "\(format(a)) \(op) \(format(b)) =",
            answer: result
        )
    }
    
    func generateAnswers() {
        var set: Set<Double> = [correctAnswer]
        
        while set.count < 5 {
            let variation = Double.random(in: -1.0...1.0)
            let wrong = (correctAnswer + variation).rounded(toPlaces: 2)
            
            if wrong != correctAnswer {
                set.insert(wrong)
            }
        }
        
        answers = Array(set).shuffled()
    }
    
    func checkAnswer(_ selected: Double) {
        if selected == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
        
        generateTest()
    }
    
    func format(_ num: Double) -> String {
        String(format: "%.2f", num)
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
