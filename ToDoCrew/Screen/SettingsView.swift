//
//  SettingsView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    @EnvironmentObject var themeManager: ThemeManager
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text("Choose the App icon")) {
                        Picker(selection: $iconSettings.currentIndex, label: HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 9, style: .continuous)
                                    .stroke(.primary, lineWidth: 2)
                                
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundColor(.primary)
                            } //: ZStack
                            .frame(width: 36, height: 36)
                            
                            Text("AppIcon")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                        .resizable()
                                        .renderingMode(.original)
                                        .scaledToFit()
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(9)
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                } //: HStack
                                .padding(3)
                            } //: ForEach
                        } //: Picker
                        .pickerStyle(.navigationLink)
                        .onChange(of: iconSettings.currentIndex) { newValue in
                            iconSettings.updateAppIcon(to: newValue)
                        } //: onChange
                    } //: Section
                    .padding(.vertical, 3)
                    
                    Section(header:
                        HStack {
                            Text("Choose the app theme")
                            .padding(.trailing, 3)
                            
                            Image(systemName: "circle.dashed.inset.filled")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(themeManager.current.color)
                        }
                    ) {
                        List {
                            ForEach(Theme.allCases, id: \.self) { theme in
                                Button {
                                    themeManager.current = theme
                                } label: {
                                    HStack {
                                        Text(theme.rawValue)

                                        Spacer()

                                        Image(systemName: theme.rawValue == themeManager.current.rawValue ? "circle.dashed.inset.filled" : "circle.dashed")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(theme.color)
                                    } //: HStack
                                } //: Button
                                .foregroundColor(.primary)
                            } //: ForEach
                        } //: List
                    } //: Section
                    .padding(.vertical, 3)
                    
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://github.com")
                        FormRowLinkView(icon: "link", color: .blue, text: "Twitter", link: "https://twitter.com")
                        FormRowLinkView(icon: "play.rectangle", color: .green, text: "Courses", link: "https://udemy.com")
                    } //: Section
                    .padding(.vertical, 3)
                    
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Petar")
                        FormRowStaticView(icon: "paintbrush", firstText: "Thanks to", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } //: Section
                    .padding(.vertical, 3)
                } //: Form
                
                //MARK: - Footer
                Text("Copyright © Petar Novakovic \nAll right reserved")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //: VStack
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })) //: navigationBarItems
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(.colorBackground)
        } //: NavigationStack
        .accentColor(themeManager.current.color)
    }
}

//MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
            .environmentObject(ThemeManager.shared)
    }
}
