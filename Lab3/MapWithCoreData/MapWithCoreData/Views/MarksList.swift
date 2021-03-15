//
//  MarksList.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import SwiftUI
import CoreData

struct MarksList: View {
    @Environment(\.presentationMode) var presentationMode
    var viewContext: NSManagedObjectContext
    var marks: FetchedResults<Mark>
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        ZStack {
            VStack {
                Text("No Places").padding(.vertical, 30)
                Spacer()
            }
            if !marks.isEmpty {
                List {
                    ForEach(marks) { mark in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(mark.markTitle ?? "Undefined")
                                    .font(.title)
                                Text(mark.markSubtitle ?? "Undefined")
                                    .font(.title3)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.body)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.currentPlace = mark
                            viewModel.currentIndex = marks.firstIndex(of: mark)!
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .onDelete(perform: deleteMark)
                }
                .navigationBarTitle("Marks", displayMode: .inline)
            }
        }
        
    }
        
    func deleteMark(offsets: IndexSet) {
        offsets.map{ marks[$0] }.forEach(viewContext.delete)
        viewModel.saveContext(viewContext: viewContext)
    }
}
