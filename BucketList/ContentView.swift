//
//  ContentView.swift
//  BucketList
//
//  Created by saj panchal on 2021-08-10.
//

import SwiftUI
import LocalAuthentication

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
    @State private var isUnlocked = false
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "Dravid", lastName: "Lister")
    ].sorted()
    var body: some View {
        /*Text("Hello World")
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
            }*/
        //MapView().edgesIgnoringSafeArea(.all)
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            }
            else {
                Text("Locked")
            }
        }.onAppear(perform: {
            authenicate()
        })
    }
    func getDocumentsDirectory() -> URL {
        // locate all documents directories for this computer user.
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first directory.
        return paths[0]
    }
    func authenicate() {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
