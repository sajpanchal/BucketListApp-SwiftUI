//
//  MapView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-12.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
   
    func makeUIView(context: Context) -> some UIView {
        let mapView = MKMapView()
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
