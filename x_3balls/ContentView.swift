import SwiftUI

struct ContentView: View {
    @State private var offsetX: CGFloat = -100
    @State private var randomNumber: Int = Int.random(in: 1...100)
    @State private var randomColor: Color = Color.random()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(randomColor)
                .frame(width: 100, height: 100)
                .overlay(
                    Text("\(randomNumber)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .offset(x: offsetX, y: 0)
                .onAppear {
                    let baseAnimation = Animation.linear(duration: 5.0)
                    let repeated = baseAnimation.repeatForever(autoreverses: false)
                    
                    withAnimation(repeated) {
                        offsetX = 500 // 화면 오른쪽으로 통과하기 위한 임의의 값
                    }
                    
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        randomNumber = Int.random(in: 1...100)
                        randomColor = Color.random()
                        offsetX = -20 // 다시 시작 위치로 초기화
                        
                        withAnimation(baseAnimation) {
                            offsetX = 2300 // 다시 오른쪽으로 이동
                        }
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
