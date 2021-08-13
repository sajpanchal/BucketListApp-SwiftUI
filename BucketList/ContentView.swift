//
//  ContentView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-10.
//

import SwiftUI
import LocalAuthentication
import MapKit
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    //overloading < method of Comparable protocol.
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}
struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State var locations = [MKPointAnnotation]()
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "Dravid", lastName: "Lister")
    ].sorted()
    var body: some View {
       
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, annotations: locations)
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
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
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
    func getDocumentsDirectory() -> URL {
        // locate all documents directories for this computer user.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first directory.
        return paths[0]
    }
    /*func authenicate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                    else {
                        
                    }
                }
            }
        }
    }*/
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
