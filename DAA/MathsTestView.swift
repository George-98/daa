import SwiftUI

struct MathsTestView: View {
    
    @StateObject var viewModel = StandardGameViewModel()
    
    struct Question: Identifiable {
        let id = UUID()
        let text: String
        let answer: Double
    }
    
    @State private var question: Question?
    @State private var answers: [Double] = []
    @State private var correctAnswer: Double = 0
    
    @State private var timeRemaining: Int = 5
    @State private var timer: Timer?
    
    @State private var correctAnswers = Int()
    
    @State private var questionNumber: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    var onGameEnd: (GameResult, [WrongAnswer]) -> Void
    
    var body: some View {
        ZStack {
            Color.themeBlue.ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                    }
                    
                    Spacer()
                    
                    Text("⏱ \(timeRemaining)s")
                }
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                if let q = question {
                    ZStack {
                        // Optional background panel (subtle)
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black.opacity(0.2))
                        
                        Text(q.text)
                            .foregroundColor(.white)
                            .font(.system(size: 42, weight: .bold, design: .monospaced)) // 🔥 bigger
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5) // prevents overflow
                            .lineLimit(2)
                            .padding()
                    }
                    .frame(minHeight: 150)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
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
        correctAnswer = 0;
        viewModel.wrongAnswersArray = [];
        timeRemaining = self.timeRemaining;
        generateTest();
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                
                var score: Int = correctAnswers - viewModel.wrongAnswersArray.count;
                
                score = score < 0 ? 0 : score;
                onGameEnd(
                    GameResult(
                        score: score,
                        correct: correctAnswers,
                        wrong: viewModel.wrongAnswersArray.count
                    ),
                    viewModel.wrongAnswersArray
                )
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
        questionNumber += 1
        
        if selected == correctAnswer {
            correctAnswer += 1
        } else {
            // SAVE WRONG ANSWER
            viewModel.wrongAnswersArray.append(
                WrongAnswer(
                    questionNumber: questionNumber,
                    question: question?.text ?? "",
                    correctAnswer: "Correct answer: \(format(correctAnswer))",
                    yourAnswer: "Your answer: \(format(selected))"
                )
            )
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
