//
//  SchoolVC.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit
import Combine

// Demo how to integrate swiftUI into UIKit project

final class SchoolVC: UIViewController {
    
    let schoolNameLbl: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 20, weight: .medium)
        return v
    }()
    
    var viewModel: SchoolVCViewModel
    var observers: Set<AnyCancellable> = []
    
    init(school: School) {
        self.viewModel = SchoolVCViewModel(school: school)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init: coder not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
    
    private func setupViews() {
        
    }
    
    private func setupObservers() {
        viewModel.$schoolName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.schoolNameLbl.text = $0
            }
            .store(in: &observers)
        
//        viewModel.$scores
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] in
//
//            }
//            .store(in: &observers)
    }
    
}
