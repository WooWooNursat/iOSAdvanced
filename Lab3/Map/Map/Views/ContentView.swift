//
//  ContentView.swift
//  Map
//
//  Created by Nursat on 23.02.2021.
//

import SwiftUI
import MapKit
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var marks: FetchedResults<Mark> {
        didSet {
            viewModel.marks = marks.filter{ _ in true }
            viewModel.currentPlace = marks.first
        }
    }
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    @State var latitude: Float = 0
    @State var longitude: Float = 0
    @State private var showAlert = false
    
    var body: some View {
        let map = MapView(viewModel: viewModel)
        NavigationView {
            ZStack(alignment: .bottom){
                map
                    .gesture(LongPressGesture(minimumDuration: 0.5).sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                                    .onEnded { value in
                                        switch value {
                                            case .second(true, let drag):
                                                let longPressLocation = drag?.location ?? .zero
                                                let newCoordinates: CLLocationCoordinate2D = map.mapView.convert(longPressLocation, toCoordinateFrom: map.mapView)
                                                self.latitude = Float(newCoordinates.latitude)
                                                self.longitude = Float(newCoordinates.longitude)
                                                self.showAlert = true
                                        
                                            default:
                                                break
                                        }
                                })
                HStack {
                    Button(action: {
                        guard !viewModel.marks.isEmpty else { return }
                        guard viewModel.marks[viewModel.currentIndex - 1] != nil else {
                            viewModel.currentIndex = viewModel.marks.count - 1
                            viewModel.currentPlace = viewModel.marks[viewModel.currentIndex]
                            return
                        }
                        viewModel.currentIndex = viewModel.currentIndex - 1
                        viewModel.currentPlace = viewModel.marks[viewModel.currentIndex]
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
                        guard !viewModel.marks.isEmpty else { return }
                        guard viewModel.marks[viewModel.currentIndex + 1] != nil else {
                            viewModel.currentIndex = 0
                            viewModel.currentPlace = viewModel.marks[viewModel.currentIndex]
                            return
                        }
                        viewModel.currentIndex = viewModel.currentIndex + 1
                        viewModel.currentPlace = viewModel.marks[viewModel.currentIndex]
                    }, label: {
                        Text("Button-right").hidden()
                    })
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                }
                .frame(height: 100)
                .toolbar(content: {
                })
                .background(BlurView(style: .systemMaterial))
                if self.showAlert {
                    AlertControlView(viewContext: _viewContext,showAlert: $showAlert, title: "Add Place", message: "Fill all the fields", latitude: self.latitude, longitude: self.longitude, viewModel: viewModel)
                }
            }
            .navigationBarTitle(viewModel.currentPlace?.markTitle ?? "", displayMode: .inline)
            .ignoresSafeArea(.all)
        }
    }
}


















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
