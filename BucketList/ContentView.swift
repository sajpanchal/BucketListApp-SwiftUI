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
        List(users) { user in
            Text("\(user.firstName)  \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
