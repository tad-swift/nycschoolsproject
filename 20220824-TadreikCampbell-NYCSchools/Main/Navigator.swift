//
//  Navigator.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit

struct Navigator {
    
    static var rootVC: UIViewController? {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return nil }
        guard let root = sceneDelegate.window?.rootViewController else { return nil }
        return root
    }
    
    static func showSchool(_ school: School) {
        let vc = SchoolVC(school: school)
        rootVC?.show(vc, sender: nil)
    }
    
}
