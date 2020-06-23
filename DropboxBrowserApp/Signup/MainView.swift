//
//  MainView.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 20/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit

class MainView: BaseView {
    private let viewModel: MainViewModel
    private let scrollView: UIScrollView = UIScrollView()
    
    private enum Constants {
        static let signInButtonHeight: CGFloat = 60.0
    }
    
    let signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Sign In with Dropbox account", for: .normal)
        button.setTitle("", for: .disabled)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .blue
        return button
    }()
    
    init(frame: CGRect = .zero, viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        setupScrollView()
        setupSignInButton()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        NSLayoutConstraint.activate(
            [scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
             scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
             scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func setupSignInButton() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(signInButton)
        
        NSLayoutConstraint.activate(
            [signInButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
             signInButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
             signInButton.heightAnchor.constraint(equalToConstant: Constants.signInButtonHeight)])
        
        signInButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
    }
    
    @objc func signUp(){
        viewModel.signUp()
    }
}
