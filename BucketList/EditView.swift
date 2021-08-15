//
//  EditView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-14.
//

import SwiftUI
import MapKit

struct EditView: View {
    //to dismiss this view.
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place Name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
            }
            .navigationTitle("Edit place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
