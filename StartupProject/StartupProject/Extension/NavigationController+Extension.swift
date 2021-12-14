//
//  NavigationController+Extension.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 02/12/21.
//

import Foundation
import UIKit
extension UINavigationController {
    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void){
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}
