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
    // pinned location instance
    @ObservedObject var placemark: MKPointAnnotation
   // to show the status of the JSON API Request.
    enum LoadingState {
        case loading, loaded, failed
    }
    @State var loadingState = LoadingState.loading
    @State var pages = [Page]()
    var body: some View {
        NavigationView {
            Form {
                // set the title and desc of the pinned location.
                Section {
                    TextField("Place Name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                // publish the list of pages fetched from wifi JSON API if data is loaded successfully.
                Section(header: Text("Nearby..."))  {
                    if loadingState == .loaded {
                        List(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline) + Text(": ") + Text(page.description)
                                .italic()
                        }
                    }
                    else if loadingState == .loading {
                        Text("Loading...")
                    }
                    else {
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Edit place")
            // when this btn is pressed dismiss the view.
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
            // fetch the API request.
            .onAppear(perform: fetchNearbyPlaces)
        }
    }
    func fetchNearbyPlaces() {
        // set URL String
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        // create an url instance from urlString
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        // instantiate the URL Session.
        URLSession.shared.dataTask(with: url) { data, response, error in
            // if the URL session is responding with data
            if let data = data {
                // we got some data back.
                // create a decoder.
                let decoder = JSONDecoder()
                // decode the data using a decoder and store it in an instance items of Result Struct.
                if let items = try? decoder.decode(Result.self, from: data) {
                    // success - convert the array values to our pages array.
                  
                    self.pages = Array(items.query.pages.values).sorted()
                    self.loadingState = .loaded
                    return
                }
            }
            self.loadingState = .failed
            
        }.resume()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
