import SwiftUI;

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            CustomButtonLabel(title: title)
        }
    }
}

struct CustomButtonLabel: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: 90)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.themeBlue)
                    )
            )
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(height: 55)
            .background(Color.white.opacity(0.1))
            .cornerRadius(15)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
    }
}
