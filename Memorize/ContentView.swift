import SwiftUI

struct ContentView: View {
    let themes: [EmojiTheme] = [
        EmojiTheme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "👹", "💀"]),
        EmojiTheme(name: "Animals", emojis: ["🦁", "🐯", "🐶", "🐱", "🐭", "🦊"]),
        EmojiTheme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️"])
    ]
    
    @State var currentTheme: EmojiTheme
    @State var cardStates: [Bool]
    
    init() {
        let defaultTheme = themes.first!
        _currentTheme = State(initialValue: defaultTheme)
        _cardStates = State(initialValue: Array(repeating: true, count: defaultTheme.emojis.count * 2))
    }
    
    var body: some View {
        VStack {
            Text("Memorize")
            
            ScrollView {
                cards
            }
            Spacer()
            HStack {
                ForEach(themes, id: \.name) { theme in
                    Button(theme.name) {
                        currentTheme = EmojiTheme(name: theme.name, emojis: theme.emojis.shuffled())
                        cardStates = Array(repeating: true, count: theme.emojis.count * 2)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<(currentTheme.emojis.count * 2), id: \.self) { index in
                let emoji = currentTheme.emojis[index / 2]
                CardView(content: emoji, isFaceUp: cardStates[index]) {
                    cardStates[index].toggle()
                }
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
}

struct EmojiTheme: Identifiable {
    var id: String { name }
    let name: String
    var emojis: [String]
}

struct CardView: View {
    let content: String
    let isFaceUp: Bool
    let onCardTap: () -> Void
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            onCardTap()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
