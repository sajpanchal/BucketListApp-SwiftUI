//
//  MapView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-12.
//

import SwiftUI
import MapKit
// this is the Struct that is responsible to display the mapView of UIKit and responde to any changes happening from SwiftUI to it.
struct MapView: UIViewRepresentable {
    // stores the lat, long of the center of the mapView.
    @Binding var centerCoordinate: CLLocationCoordinate2D
    // creates a pinned location instance having title, subtitle, lat and long.
    @Binding var selectedPlace: MKPointAnnotation?
    // flag that decides whether to show the EditView or not.
    @Binding var showingPlaceDetails: Bool
    
    // list of pinned location instances.
    var annotations: [MKPointAnnotation]
    
    // acts as a mediator between swiftUI and UIKit.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
        }
        // when we scroll or zoom in/out the map this method gets called.
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            // get the centerCoordinates and store it in parent instance prop of MapView.
            parent.centerCoordinate = mapView.centerCoordinate
        }
        // to reuse the existing pinned location from a MapKit or create a new one when + button is clicked.
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        // when accesoryControl is tapped on pinned location.
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else {
                return
            }
            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
            
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
   
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Waterloo"
        annotation.subtitle = "MY Home"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 43.46, longitude: -80.51)
        return annotation
    }
}

