//
//  HomeView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-15.
//

import SwiftUI
import MapKit
struct HomeView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool
    var body: some View {
        Group {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(centerCoordinate: .constant(CLLocationCoordinate2D()), locations: .constant([CodableMKPointAnnotation]()), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), showingEditScreen: .constant(false))
    }
}
