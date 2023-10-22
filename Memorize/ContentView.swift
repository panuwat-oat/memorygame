//
//  ContentView.swift
//  Memorize
//
//  Created by Class Demo on 5/10/2566 BE.
//

import SwiftUI

let themes: [Theme] = [
    Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "👹"], symbol: "moon"),
    Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🦊"], symbol: "cat"),
    Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️"], symbol: "soccerball")
]


struct ContentView: View {
    
    @State private var currentTheme: Theme = themes[0].randomizedEmojis()
    
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
                .foregroundColor(.purple)
            ScrollView {
                cards
            }
            
            HStack {
                ForEach(themes, id: \.name) { theme in
                    Button(action: {
                        self.currentTheme = theme.randomizedEmojis()
                    }) {
                        HStack {
                            Image(systemName: theme.symbol) // ใช้ SF Symbol ที่ต้องการ
                                .font(.title)
                            Text(theme.name)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal, 8)  // ปรับ padding แนวนอน
                    .padding(.vertical, 4)    // ปรับ padding แนวตั้ง
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(currentTheme.emojis.indices, id: \.self) { index in
                CardView(content: currentTheme.emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(.orange)
    }
    
}

struct Theme {
    let name: String
    var emojis: [String]
    let symbol: String // เพิ่มตัวแปรสำหรับ SF Symbol
    
    func randomizedEmojis() -> Theme {
        return Theme(name: self.name, emojis: self.emojis.doubled().shuffled(), symbol: self.symbol)
    }
}


extension Array {
    func doubled() -> [Element] {
        print(self + self)
        return self + self
    }
}



struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
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
            isFaceUp.toggle()
        }
    }
}





#Preview {
    ContentView()
}
