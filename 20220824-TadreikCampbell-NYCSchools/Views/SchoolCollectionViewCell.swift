//
//  SchoolCollectionViewCell.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit
import Combine

class SchoolCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "school-cell-id"
    
    private let nameLbl: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .systemFont(ofSize: 20, weight: .medium)
        return v
    }()
    
    private let descLbl: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var viewModel: SchoolCellViewModel! {
        didSet {
            setupObservers()
        }
    }
    private(set) var observers: Set<AnyCancellable> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        observers.removeAll()
    }
    
    private func setupViews() {
        contentView.addSubviews(nameLbl, descLbl)
        NSLayoutConstraint.activate([
            nameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 10),
            descLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupObservers() {
        viewModel.$schoolName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.nameLbl.text = $0
            }
            .store(in: &observers)
        
        viewModel.$schoolDescription
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.descLbl.text = $0
            }
            .store(in: &observers)
    }
    
}
