//
//  AddToDoView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct AddToDoView: View {
    
    //MARK: - Properties
    @ObservedObject var viewModel: TodoViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager
    @State private var name = ""
    @State private var priority: String
    @State private var errorShowing = false
    
    //MARK: - Init
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
        _priority = State(initialValue: viewModel.priorities[1])
    }
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Form {
                        TextField(Localization.todo, text: $name)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .accentColor(themeManager.current.color)
                        
                        Picker(Localization.priority, selection: $priority) {
                            ForEach(viewModel.priorities, id: \.self) { priority in
                                Text(priority)
                            } //: ForEach
                        } //: Picker
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button {
                            if viewModel.isValidTodo(name: name) {
                                viewModel.addTodo(name: name, priority: priority)
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                errorShowing = true
                            }
                        } label: {
                            Text(Localization.save)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(themeManager.current.color)
                                .cornerRadius(9)
                                .foregroundColor(.white)
                        } //: Button
                    } //: Form
                } //: VStack
                .padding(.vertical, 30)
                
                Spacer()
            } //: VStack
            .navigationBarTitle(Localization.newTodo, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: Constants.systemXmark)
            })) //: navigationBarItems
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(viewModel.errorTitle), message: Text(viewModel.errorMessage), dismissButton: .default(Text(Localization.oK).foregroundColor(.black)))
            } //: alert
        } //: NavigationStack
        .accentColor(themeManager.current.color)
    }
}

//MARK: - Preview
struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        AddToDoView(viewModel: TodoViewModel(context: context))
            .environmentObject(ThemeManager.shared)
    }
}
