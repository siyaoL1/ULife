//
//  test.swift
//  Note
//
//  Created by Hongyang Lin on 3/30/21.
//

import SwiftUI

struct AppContentView: View {
    
    @State var signInSuccess = false
    
    var body: some View {
        return Group {
            if signInSuccess {
                AppHome()
            }
            else {
                LoginFormView(signInSuccess: $signInSuccess)
            }
        }
    }
}

struct LoginFormView : View {
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    @State private var showError = false
    
    @Binding var signInSuccess: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("User name")
                TextField("type here", text: $userName)
            }.padding()
            
            HStack {
                Text(" Password")
                TextField("type here", text: $password)
                    .textContentType(.password)
            }.padding()
            
            Button(action: {
                // Your auth logic
                if(self.userName == self.password) {
                    self.signInSuccess = true
                }
                else {
                    self.showError = true
                }
                
            }) {
                Text("Sign in")
            }
            
            if showError {
                Text("Incorrect username/password").foregroundColor(Color.red)
            }
        }
    }
}

struct AppHome: View {
    
    var body: some View {
        VStack {
        Text("Hello freaky world!")
        Text("You are signed in.")
        }
    }
}


struct test_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
