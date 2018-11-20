//
//  ViewController.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit


let customButton : UIButton = {
    let button = UIButton()
    button.setTitle("YO!", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}()

class ViewController: UIViewController {

    @IBOutlet var skipButton: UIButton!

    
    fileprivate func items(customButton: UIButton)->[OnboardingItemInfo]{ return [
        OnboardingItemInfo(informationImage: Asset.hotels.image,
                           title: "Hotels",
                           description: "All hotels and hostels are sorted by hospitality rating",
                           customView: customButton,
                           pageIcon: Asset.key.image,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: ViewController.titleFont, descriptionFont: ViewController.descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.banks.image,
                           title: "Banks",
                           description: "We carefully verify all banks before add them into the app",
                           pageIcon: Asset.wallet.image,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: ViewController.titleFont, descriptionFont: ViewController.descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.stores.image,
                           title: "Stores",
                           description: "All local stores are categorized for your convenience",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: ViewController.titleFont, descriptionFont: ViewController.descriptionFont),
        
        ]}
    
    var items: [OnboardingItemInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true

        setupPaperOnboardingView()

        view.bringSubviewToFront(skipButton)
    }

    @objc func customButtonAction(_ sender: UIButton) {
        print("Click!")
    }
    
    private func setupPaperOnboardingView() {
        customButton.addTarget(self, action: #selector(ViewController.customButtonAction(_:)), for: .touchUpInside)
        items = items(customButton: customButton)
        let onboarding = PaperOnboarding(pageViewBottomConstant: 70, pageViewRadius: 8, pageViewSelectedRadius: 8)
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
}

// MARK: Actions

extension ViewController {

    @IBAction func skipButtonTapped(_: UIButton) {
        print(#function)
    }
}

// MARK: PaperOnboardingDelegate

extension ViewController: PaperOnboardingDelegate {

    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }

    func onboardingDidTransitonToIndex(_: Int) {
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource

extension ViewController: PaperOnboardingDataSource {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
    
    func onboardingPageItemsHaveParalax() -> Bool {
        return true
    }
}


//MARK: Constants
extension ViewController {
    
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

