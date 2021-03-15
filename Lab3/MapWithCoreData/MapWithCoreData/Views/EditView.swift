//
//  EditView.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import SwiftUI
import CoreData

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    var viewContext: NSManagedObjectContext
    @ObservedObject var viewModel: ContentViewModel
    var mark: Mark
    @State var title: String
    @State var subtitle: String
    init(coordinate: CLLocationCoordinate2D, marks: FetchedResults<Mark>, viewContext: NSManagedObjectContext, viewModel: ContentViewModel) {
        self.viewContext = viewContext
        self.viewModel = viewModel
        self.mark = marks.first(where: {
            $0.markLatitude == Float(coordinate.latitude) &&
            $0.markLongitude == Float(coordinate.longitude)
        })!
        _title = State(initialValue: (self.mark.markTitle)!)
        _subtitle = State(initialValue: (self.mark.markSubtitle)!)
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 60) {
                TextField("title", text: $title)
                    .padding(10)
                    .border(Color.gray, width: 0.5)
                    .cornerRadius(6)
                    .background(Color.white)
                    .padding(.horizontal,50)
                    .padding(.top, 150)
                TextField("subtitle", text: $subtitle)
                    .padding(10)
                    .border(Color.gray, width: 0.5)
                    .cornerRadius(6)
                    .background(Color.white)
                    .padding(.horizontal,50)
                Spacer()
            }
            .background(Color(red: 149/255, green: 195/255, blue: 248/255))
            .navigationBarTitle("Edit", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                mark.markTitle = title
                mark.markSubtitle = subtitle
                viewModel.saveContext(viewContext: viewContext)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            }))
            .ignoresSafeArea(.all)
        }
    }
}
