//
//  HeaderView.swift
//  Deliver
//
//  Created by Karun Pant on 28/09/20.
//

import UIKit

class HeaderView: UICollectionReusableView {
    private let label: UILabel
    override init(frame: CGRect) {
        label = UILabel()
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setTitle(_ title: String) {
        label.text = title
    }
}
