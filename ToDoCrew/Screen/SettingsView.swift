//
//  SettingsView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: SettingsViewModel
    
    //MARK: - Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text(Localization.chooseIcon)) {
                        Picker(selection: $viewModel.iconManager.currentIndex, label: HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 9, style: .continuous)
                                    .stroke(.primary, lineWidth: 2)
                                
                                Image(systemName: Constants.systemPaintbrush)
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundColor(.primary)
                            } //: ZStack
                            .frame(width: 36, height: 36)
                            
                            Text(Localization.appIcon)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }) {
                            ForEach(0..<viewModel.iconManager.iconNames.count, id: \.self) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: viewModel.iconManager.iconNames[index] ?? "Blue") ?? UIImage())
                                        .resizable()
                                        .renderingMode(.original)
                                        .scaledToFit()
                                        .frame(width: 36, height: 36)
                                        .cornerRadius(9)
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(viewModel.iconManager.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                } //: HStack
                                .padding(3)
                            } //: ForEach
                        } //: Picker
                        .pickerStyle(.navigationLink)
                        .onChange(of: viewModel.iconManager.currentIndex) { newValue in
                            viewModel.updateAppIcon(to: newValue)
                        } //: onChange
                    } //: Section
                    .padding(.vertical, 3)
                    
                    Section(header:
                        HStack {
                        Text(Localization.chooseTheme)
                            .padding(.trailing, 3)
                            
                        Image(systemName: Constants.systemCircleDashedFilled)
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(viewModel.currentTheme.color)
                        }
                    ) {
                        List {
                            ForEach(Theme.allCases, id: \.self) { theme in
                                Button {
                                    viewModel.updateTheme(to: theme)
                                } label: {
                                    HStack {
                                        Text(theme.title)

                                        Spacer()

                                        Image(systemName: theme.rawValue == viewModel.currentTheme.rawValue ? Constants.systemCircleDashedFilled : Constants.systemCircleDashed)
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
                    
                    Section(header: Text(Localization.followUs)) {
                        FormRowLinkView(icon: Constants.globe, color: .pink,
                            text: Localization.website, link: Constants.gitHub)
                        FormRowLinkView(icon: Constants.link, color: .blue,
                            text: Localization.twitter, link: Constants.twitter)
                        FormRowLinkView(icon: Constants.playRectangle, color: .green,
                            text: Localization.courses, link: Constants.udemy)
                    } //: Section
                    .padding(.vertical, 3)
                    
                    Section(header: Text(Localization.aboutTheApp)) {
                        FormRowStaticView(icon: Constants.gear,
                            firstText: Localization.application, secondText: Localization.todo)
                        FormRowStaticView(icon: Constants.checkmarkSeal,
                            firstText: Localization.compatibility, secondText: Localization.iPhoneIPad)
                        FormRowStaticView(icon: Constants.keyboard,
                            firstText: Localization.developer, secondText: Localization.developerValue)
                        FormRowStaticView(icon: Constants.paintbrush,
                            firstText: Localization.thanksTo, secondText: Localization.thanksToValue)
                        FormRowStaticView(icon: Constants.flag,
                            firstText: Localization.version, secondText: Localization.versionValue)
                    } //: Section
                    .padding(.vertical, 3)
                } //: Form
                
                //MARK: - Footer
                Text(Localization.copyrightInfo)
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //: VStack
            .navigationBarItems(trailing: Button(action: {
                dismiss()
            }, label: {
                Image(systemName: Constants.systemXmark)
            })) //: navigationBarItem
            .navigationBarTitle(Localization.settings, displayMode: .inline)
            .background(.colorBackground)
        } //: NavigationStack
        .accentColor(viewModel.currentTheme.color)
    }
}

//MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let settingsViewModel = SettingsViewModel(iconManager: IconManager(), themeManager: ThemeManager.shared)
        SettingsView(viewModel: settingsViewModel)
    }
}
