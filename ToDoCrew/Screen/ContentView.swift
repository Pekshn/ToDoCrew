//
//  ContentView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    @State private var showingAddTodoView = false
    @State private var animatingButton = false
    @State private var showingSettingsView = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath:
        \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    @EnvironmentObject var iconSettings: IconNames
    @EnvironmentObject var themeManager: ThemeManager
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(todos, id: \.self) { todo in
                        HStack {
                            Circle()
                                .frame(width: 15, height: 15, alignment: .center)
                                .foregroundColor(self.colorize(priority: todo.priority ?? ""))
                                .padding(.trailing, 10)
                            
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundColor(.init(uiColor: UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay {
                                    Capsule()
                                        .stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                }
                        } //: HStack
                        .padding(.vertical, 10)
                    } //: ForEach
                    .onDelete(perform: deleteTodo)
                } //: List
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingSettingsView.toggle()
                }, label: {
                    Image(systemName: "paintbrush")
                }))
                .sheet(isPresented: $showingSettingsView) {
                    SettingsView()
                        .environmentObject(self.iconSettings)
                }
                
                //MARK: - No ToDo items
                if todos.isEmpty {
                    EmptyListView()
                }
            } //: ZStack
            .sheet(isPresented: $showingAddTodoView) {
                AddToDoView()
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(alignment: .bottomTrailing) {
                ZStack {
                    Group {
                        Circle()
                            .fill(themeManager.current.color)
                            .opacity(animatingButton ? 0.25 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themeManager.current.color)
                            .opacity(animatingButton ? 0.15 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animatingButton)
                    
                    Button {
                        self.showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(.colorBase))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: Button
                    .accentColor(themeManager.current.color)
                    .onAppear {
                        animatingButton.toggle()
                    }
                } //: ZStack
                .padding(.bottom, 15)
                .padding(.trailing, 15)
            } //: overlay
        } //: NavigationStack
        .accentColor(themeManager.current.color)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//MARK: - Private API
extension ContentView {
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "Low": return .green
        case "Medium": return .yellow
        case "High": return .pink
        default: return .gray
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        ContentView()
            .environment(\.managedObjectContext, context)
            .environmentObject(IconNames())
            .environmentObject(ThemeManager())
    }
}
