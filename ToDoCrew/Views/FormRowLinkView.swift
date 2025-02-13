//
//  FormRowLinkView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct FormRowLinkView: View {
    
    //MARK: - Properties
    var icon: String
    var color: Color
    var text: String
    var link: String
    var openURL: (URL) -> Void = { UIApplication.shared.open($0) }
    
    //MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            } //: ZStack
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button {
                guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
                openURL(url)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .accentColor(Color(.systemGray2))
            } //: Button
        } //: HStack
    }
}

//MARK: - Preview
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://github.com")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
