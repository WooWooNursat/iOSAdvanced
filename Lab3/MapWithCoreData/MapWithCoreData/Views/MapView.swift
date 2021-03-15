//
//  MapView.swift
//  MapWithCoreData
//
//  Created by Nursat on 24.02.2021.
//

import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate{
    var control: MapView
    
    init(_ control: MapView){
        self.control = control
    }
    
    @objc func handlePress(_ gesture: UILongPressGestureRecognizer) {
        let mapView = control.mapView
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        control.viewModel.showAlert(coordinate: coordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // this is our unique identifier for view reuse
        let identifier = "Placemark"

        // attempt to find a cell we can recycle
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            // we didn't find one; make a new one
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

            // allow this to show pop up information
            annotationView?.canShowCallout = true

        } else {
            // we have a view to reuse, so give it the new annotation
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .blue

        // attach an information button to the view
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        // whether it's a new view or a recycled one, send it back
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.control.viewModel.editMark(coordinate: view.annotation!.coordinate)
    }
}

struct MapView: UIViewRepresentable {
    @ObservedObject var viewModel: ContentViewModel
    var marks: FetchedResults<Mark>
    var mapView = MKMapView()
    
    var mapTypeDict: [String: MKMapType] = [
        "Normal": .standard,
        "Hybrid": .hybrid,
        "Satellite": .satellite
    ]
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        let longGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePress(_:)))
        mapView.addGestureRecognizer(longGesture)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.mapType = mapTypeDict[viewModel.mapType] ?? .standard
        uiView.removeAnnotations(uiView.annotations)
        if let currentPlace = viewModel.currentPlace {
            if marks.contains(currentPlace) {
                uiView.setRegion(.init(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(currentPlace.markLatitude), longitude: CLLocationDegrees(currentPlace.markLongitude)), latitudinalMeters: 1000000, longitudinalMeters: 1000000), animated: true)
            }
        }
        marks.forEach {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.markLatitude), longitude: CLLocationDegrees($0.markLongitude))
            annotation.title = $0.markTitle
            annotation.subtitle = $0.markSubtitle
            uiView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
