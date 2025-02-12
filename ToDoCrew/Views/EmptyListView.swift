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
    @State private var selectedImage: String
    @State private var selectedTip: String
    @EnvironmentObject var themeManager: ThemeManager
    private let images = ["illustration-no1", "illustration-no2", "illustration-no3"]
    private let tips = ["Use your time wisely.",
                        "Slow and steady wins the race.",
                        "Keep it short and sweet.",
                        "Put hard tasks first.",
                        "Reward your self after work.",
                        "Collect tasks ahead of time",
                        "Each night schedule for tomorrow."]
    
    //MARK: - Init
    init() {
        _selectedImage = State(initialValue: images.randomElement() ?? "illustration-no1")
        _selectedTip = State(initialValue: tips.randomElement() ?? "Use your time wisely.")
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(selectedImage)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360,
                           minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                    .foregroundColor(themeManager.current.color)
                
                Text(selectedTip)
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(themeManager.current.color)
            } //: VStack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .onAppear {
                withAnimation(.easeOut(duration: 1.5)) {
                    isAnimated.toggle()
                }
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
        EmptyListView()
            .environmentObject(ThemeManager())
            .previewLayout(.sizeThatFits)
    }
}
