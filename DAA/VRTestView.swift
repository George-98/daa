import SwiftUI

struct HouseScenario: Hashable {
    let location: String
    let distanceToWork: String // raw: "near" or "far"
    let bedrooms: Int
    
    // Convert bedroom number to word
    private func numberToWord(_ number: Int) -> String {
        switch number {
        case 1: return "one"
        case 2: return "two"
        case 3: return "three"
        case 4: return "four"
        default: return "\(number)"
        }
    }
    
    var bedroomWord: String {
        numberToWord(bedrooms)
    }
    
    // Map distance to proper phrase
    var distancePhrase: String {
        switch distanceToWork {
        case "near": return "near to work"
        case "far": return "far from work"
        default: return distanceToWork
        }
    }
    
    var description: String {
        "The house is located in a \(location), \(distancePhrase) with \(bedroomWord) bedroom\(bedrooms > 1 ? "s" : "")."
    }
}

struct VRGenerator {
    static let locations = ["city", "town", "village"]
    static let distances = ["near", "far"]
    static let bedroomOptions = [1, 2, 3, 4]
    
    static func generateQuestion() -> VRQuestion {
        // Generate a random target scenario
        let target = HouseScenario(
            location: locations.randomElement()!,
            distanceToWork: distances.randomElement()!,
            bedrooms: bedroomOptions.randomElement()!
        )
        
        // Always include location, distance (as phrase), and bedrooms (as word) in the question
        let questionText = "You are looking for a house in a \(target.location), \(target.distancePhrase) with \(target.bedroomWord) bedroom\(target.bedrooms > 1 ? "s" : ""). Which scenario matches?"
        
        // Generate dynamic answer options
        var options: [HouseScenario] = [target]
        while options.count < 5 {
            let randomScenario = HouseScenario(
                location: locations.randomElement()!,
                distanceToWork: distances.randomElement()!,
                bedrooms: bedroomOptions.randomElement()!
            )
            // avoid duplicates
            if !options.contains(randomScenario) {
                options.append(randomScenario)
            }
        }
        options.shuffle()
        
        return VRQuestion(
            statement: "",
            question: questionText,
            options: options.map { $0.description },
            correctAnswer: target.description
        )
    }
}

struct VRTestView: View {
    @State private var currentQuestion: VRQuestion?
    @State private var score = 0
    @State private var timeRemaining: Int = 70
    @State private var timer: Timer?
    @State private var wrongAnswersArray: [WrongAnswer] = []
    @State private var questionCounter: Int = 0
    
    @Environment(\.dismiss) var dismiss
    var onGameEnd: (GameResult, [WrongAnswer]) -> Void
    
    var body: some View {
        ZStack {
            Color.themeBlue.ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    Text("⏱ \(timeRemaining)s")
                        .monospacedDigit()
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                
                if let q = currentQuestion {
                    VStack(spacing: 20) {
                        // QUESTION
                        Text(q.question)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.yellow)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                        
                        // ANSWER OPTIONS
                        VStack(spacing: 12) {
                            ForEach(q.options, id: \.self) { option in
                                Button {
                                    answerSelected(option)
                                } label: {
                                    Text(option)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 15)
                                        .background(Color.white)
                                        .foregroundColor(.themeBlue)
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top, 10)
        }
        .onAppear { startGame() }
    }
    
    func answerSelected(_ answer: String) {
        guard let q = currentQuestion else { return }
        questionCounter += 1
        
        if answer == q.correctAnswer {
            score += 1
        } else {
            wrongAnswersArray.append(
                WrongAnswer(
                    questionNumber: questionCounter,
                    question: q.question,
                    correctAnswer: q.correctAnswer,
                    yourAnswer: answer
                )
            )
        }
        
        generateNewQuestion()
    }
    
    func generateNewQuestion() {
        currentQuestion = VRGenerator.generateQuestion()
    }

    func startGame() {
        score = 0
        timeRemaining = self.timeRemaining;
        wrongAnswersArray = []
        questionCounter = 0
        generateNewQuestion()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                endGame()
            }
        }
    }

    func endGame() {
        timer?.invalidate()
        
        let correct = score
        let wrong = questionCounter - score
        
        onGameEnd(
            GameResult(
                score: score,
                correct: correct,
                wrong: wrong
            ),
            wrongAnswersArray
        )
    }
}
