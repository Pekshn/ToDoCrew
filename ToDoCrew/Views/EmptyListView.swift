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
    private let selectedImage: String
    private let selectedTip: String
    @EnvironmentObject var themeManager: ThemeManager
    private let images = [Constants.illustrationNo1, Constants.illustrationNo2, Constants.illustrationNo3]
    private let tips = [Localization.tip1, Localization.tip2, Localization.tip3,
                        Localization.tip4, Localization.tip5, Localization.tip6,
                        Localization.tip7]
    
    //MARK: - Init
    init(selectedImage: String? = nil, selectedTip: String? = nil) {
        self.selectedImage = selectedImage ?? images.randomElement() ?? Constants.illustrationNo1
        self.selectedTip = selectedTip ?? tips.randomElement() ?? Localization.tip1
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
            .environmentObject(ThemeManager.shared)
            .previewLayout(.sizeThatFits)
    }
}
