//
//  ContentView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 01/05/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var router = Router.navigationVM

    @StateObject var vm = ContentViewModel()

    var body: some View {

        NavigationStack(path: $router.paths, root: {
            SignUpPage(router: router, vm: vm)
                .navigationDestination(for: Path.self) { path in
                    switch path {
                    case .A: SignUpPage(router: router, vm: vm)
                    case .B: DetailsView(vm: vm)
                    case .C: Dashboard(vm: vm)
                    case .D: SignInView(router: router, vm: vm)
                    }
                }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}
