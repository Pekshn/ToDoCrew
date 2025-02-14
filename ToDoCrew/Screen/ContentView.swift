//
//  ContentView.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //MARK: - Properties
    @State private var showingAddTodoView = false
    @State private var animatingButton = false
    @State private var showingSettingsView = false
    @EnvironmentObject private var iconManager: IconManager
    @EnvironmentObject private var themeManager: ThemeManager
    @ObservedObject private var viewModel: TodoViewModel
    
    //MARK: - Init
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                List {
                    ForEach(viewModel.todos, id: \.self) { todo in
                        HStack {
                            Circle()
                                .frame(width: 15, height: 15, alignment: .center)
                                .foregroundColor(viewModel.colorize(priority: todo.priority ?? ""))
                                .padding(.trailing, 10)
                            
                            Text(todo.name ?? Localization.unknown)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? Localization.unknown)
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
                    .onDelete(perform: viewModel.deleteTodo)
                } //: List
                .navigationBarTitle(Localization.todoCrew, displayMode: .inline)
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingSettingsView.toggle()
                }, label: {
                    Image(systemName: Constants.systemPaintbrush)
                })) //: navigationBarItems
                .sheet(isPresented: $showingSettingsView) {
                    SettingsView()
                } //: sheet
                
                if viewModel.todos.isEmpty {
                    EmptyListView()
                }
            } //: ZStack
            .sheet(isPresented: $showingAddTodoView) {
                AddToDoView(viewModel: viewModel)
            } //: sheet
            .overlay(alignment: .bottomTrailing) {
                ZStack {
                    Group {
                        Circle()
                            .fill(themeManager.current.color)
                            .opacity(animatingButton ? 0.25 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 72, height: 72, alignment: .center)
                        
                        Circle()
                            .fill(themeManager.current.color)
                            .opacity(animatingButton ? 0.15 : 0)
                            .scaleEffect(animatingButton ? 1 : 0)
                            .frame(width: 96, height: 96, alignment: .center)
                    } //: Group
                    .animation(.easeIn(duration: 1.5).repeatForever(autoreverses: true), value: animatingButton)
                    
                    Button {
                        self.showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: Constants.systemPlusCircleFill)
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(.colorBase))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: Button
                    .accentColor(themeManager.current.color)
                    .onAppear {
                        animatingButton.toggle()
                    } //: onAppear
                } //: ZStack
                .padding(.bottom, 15)
                .padding(.trailing, 15)
            } //: overlay
        } //: NavigationStack
        .accentColor(themeManager.current.color)
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        ContentView(viewModel: TodoViewModel(context: context))
            .environmentObject(IconManager())
            .environmentObject(ThemeManager.shared)
    }
}
