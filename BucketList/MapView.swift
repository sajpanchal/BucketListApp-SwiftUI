//
//  MapView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-12.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
        }
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "Waterloo"
        annotation.subtitle = "My Home"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 43.46, longitude: -80.51)
        mapView.addAnnotation(annotation)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
