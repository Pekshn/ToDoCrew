//
//  EmptyListView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct EmptyListView: View {
    
    //MARK: - Properties
    @State private var isAnimated = false
    private let images = ["illustration-no1", "illustration-no2", "illustration-no3"]
    private let tips = ["Use your time wisely.",
                        "Slow and steady wins the race.",
                        "Keep it short and sweet.",
                        "Put hard tasks first.",
                        "Reward your self after work.",
                        "Collect tasks ahead of time",
                        "Each night schedule for tomorrow."]
    
    @ObservedObject var theme: ThemeSettings
    var themes: [Theme] = themeData
    
    //MARK: - Body
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(images.randomElement() ?? images[0])
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360,
                           minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                    .foregroundColor(themes[self.theme.themeSettings].themeColor)
                
                Text(tips.randomElement() ?? tips[0])
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(themes[self.theme.themeSettings].themeColor)
            } //: VStack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1), value: isAnimated)
            .onAppear {
                self.isAnimated.toggle()
            }
        } //: ZStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.colorBase)
        .ignoresSafeArea(.all, edges: .all)
    }
}

//MARK: - Preview
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(theme: ThemeSettings())
            .previewLayout(.sizeThatFits)
    }
}
