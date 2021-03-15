//
//  ContentView.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Mark.newFetchRequest) private var marks: FetchedResults<Mark>
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
        
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                MapView(viewModel: viewModel, marks: marks)
                HStack {
                    Button(action: {
                        guard !marks.isEmpty else { return }
                        guard viewModel.currentIndex != marks.endIndex - 1 else {
                            viewModel.currentIndex = 0
                            viewModel.currentPlace = marks[viewModel.currentIndex]
                            return
                        }
                        viewModel.currentIndex = viewModel.currentIndex + 1
                        viewModel.currentPlace = marks[viewModel.currentIndex]
                    }, label: {
                        Text("Button-left").hidden()
                    })
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                    Picker(selection: $viewModel.mapType, label: Text("Map Type"), content: {
                        ForEach(viewModel.mapTypes, id: \.self){
                            Text($0)
                        }
                    })
                    .frame(width: 250)
                    .pickerStyle(SegmentedPickerStyle())
                    Button(action: {
                        guard !marks.isEmpty else { return }
                        guard viewModel.currentIndex != marks.startIndex else {
                            viewModel.currentIndex = marks.count - 1
                            viewModel.currentPlace = marks[viewModel.currentIndex]
                            return
                        }
                        viewModel.currentIndex = viewModel.currentIndex - 1
                        viewModel.currentPlace = marks[viewModel.currentIndex]
                    }, label: {
                        Text("Button-right").hidden()
                    })
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                }
                .frame(height: 100)
                .background(BlurView(style: .systemMaterial))
                if self.viewModel.showAlert {
                    AlertControlView(viewContext: viewContext, title: "Add Place", message: "Fill all the fields", viewModel: viewModel)
                }
            }
            .navigationBarTitle(viewModel.currentPlace?.markTitle ?? "", displayMode: .inline)
            .navigationBarItems(trailing:
                                        NavigationLink(destination: MarksList(viewContext: viewContext,marks: marks, viewModel: viewModel)) {
                                            Image(systemName: "folder")
                                        }
                                    )
            .ignoresSafeArea(.all)
            .fullScreenCover(isPresented: $viewModel.openEditView, content: {
                EditView(coordinate: self.viewModel.coordinate, marks: self.marks, viewContext: self.viewContext, viewModel: self.viewModel)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
