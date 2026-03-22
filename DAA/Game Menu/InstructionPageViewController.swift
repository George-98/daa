import SwiftUI;

struct InstructionPageView: View {
    let instructions: [String]
    @Environment(\.dismiss) var dismiss
    let themeBlue = Color(red: 44/255, green: 62/255, blue: 95/255)
    
    var body: some View {
        ZStack {
            themeBlue.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                Text("Instructions")
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                
                // 5. Native SwiftUI Paging
                TabView {
                    ForEach(instructions, id: \.self) { instructionID in
                        VStack {
                            // Since your UIKit code uses Storyboard IDs for instructions,
                            // you would normally load those view controllers here.
                            // For pure SwiftUI, we display the name/content:
                            Text("Content for: \(instructionID)")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
        }
    }
}
