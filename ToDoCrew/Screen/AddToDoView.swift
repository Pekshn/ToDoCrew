//
//  AddToDoView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct AddToDoView: View {
    
    //MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var priority = "Normal"
    @State private var errorShowing = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    private let priorites = ["Low", "Medium", "High"]
    @EnvironmentObject var themeManager: ThemeManager
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Form {
                        TextField("Todo", text: $name)
                            .padding()
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(9)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .accentColor(themeManager.current.color)
                        
                        Picker("Priority", selection: $priority) {
                            ForEach(priorites, id: \.self) { priority in
                                Text(priority)
                            } //: ForEach
                        } //: Picker
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button {
                            if self.name != "" {
                                let todo = Todo(context: self.managedObjectContext)
                                todo.name = self.name
                                todo.priority = self.priority
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    print(error)
                                }
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                self.errorShowing = true
                                self.errorTitle = "Invalid name"
                                self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            }
                        } label: {
                            Text("Save")
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
            .navigationBarTitle("New ToDo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })) //: navigationBarItems
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK").foregroundColor(.black)))
            } //: alert
        } //: NavigationStack
        .accentColor(themeManager.current.color)
    }
}

//MARK: - Preview
struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
            .environmentObject(ThemeManager())
    }
}
