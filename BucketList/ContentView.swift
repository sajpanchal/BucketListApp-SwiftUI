//
//  ContentView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-10.
//

import SwiftUI
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
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = self.getDocumentsDirectory().appendingPathComponent("message.rtf")
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
    }
    func getDocumentsDirectory() -> URL {
        // locate all documents directories for this computer user.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first directory.
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
