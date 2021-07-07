//
//  HomeView.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/7/21.
//

import UIKit

class HomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setup() {
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        self.addSubview(backgroundView)
        self.addSubview(mainStack)
        
        mainStack.addArrangedSubview(emailLabel)
    }
    
    private func setUpConstraints() {
        backgroundView.pinEdges(to: self)
        mainStack.pinEdgesToSafeArea(of: self)
    }
    
    // MARK: - Views
    let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        return view
    }()

    let mainStack: UIStackView = {
        let stackView = UIStackView(frame: .infinite)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 30, bottom: 30, right: 30)

        return stackView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Testing home view"

        return label
    }()
}
