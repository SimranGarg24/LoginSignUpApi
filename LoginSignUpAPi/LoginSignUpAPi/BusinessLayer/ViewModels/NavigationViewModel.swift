//
//  NavigationViewModel.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 03/05/23.
//

import Foundation

class Router: ObservableObject {
    
    static let navigationVM = Router()
    @Published var paths: [Path] = []
    
    
    /// To push view in the stack
    /// - Parameter path: Path
    func push(_ path: Path) {
        paths.append(path)
    }
    
    
    /// To pop view from Stack
    func pop() {
        paths.removeLast(1)
    }
    
    
    /// To pop 2 view from stack
    func pop2() {
        paths.removeLast(1)
        paths.removeLast(1)
    }
}

enum Path {
    case A
    case B
    case C
    case D
}
