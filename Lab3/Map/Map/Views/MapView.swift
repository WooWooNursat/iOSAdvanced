//
//  MapView.swift
//  Map
//
//  Created by Nursat on 23.02.2021.
//

import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate{
    var control: MapView
    
    init(_ control: MapView){
        self.control = control
    }
}

struct MapView: UIViewRepresentable {
    @ObservedObject var viewModel: ContentViewModel
    @State var mapView: MKMapView = MKMapView()
    
    var mapTypeDict: [String: MKMapType] = [
        "Normal": .standard,
        "Hybrid": .hybrid,
        "Satellite": .satellite
    ]
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        viewModel.marks.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.markLatitude), longitude: CLLocationDegrees($0.markLongitude))
            annotation.title = $0.markTitle
            annotation.subtitle = $0.markDescription
            mapView.addAnnotation(annotation)
        }
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.mapType = mapTypeDict[viewModel.mapType] ?? .standard
        uiView.removeAnnotations(uiView.annotations)
        guard let currentPlace = viewModel.currentPlace else {
            uiView.setRegion(.init(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0)), latitudinalMeters: 1000000, longitudinalMeters: 1000000), animated: true)
            return
        }
        uiView.setRegion(.init(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(currentPlace.markLatitude), longitude: CLLocationDegrees(currentPlace.markLongitude)), latitudinalMeters: 1000000, longitudinalMeters: 1000000), animated: true)
        viewModel.marks.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.markLatitude), longitude: CLLocationDegrees($0.markLongitude))
            annotation.title = $0.markTitle
            annotation.subtitle = $0.markDescription
            uiView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
