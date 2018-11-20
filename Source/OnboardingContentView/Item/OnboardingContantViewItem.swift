//
//  OnboardingContentViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

open class OnboardingContentViewItem: UIView {

    public var descriptionBottomConstraint: NSLayoutConstraint?
    public var titleCenterConstraint: NSLayoutConstraint?
    public var informationImageWidthConstraint: NSLayoutConstraint?
    public var informationImageHeightConstraint: NSLayoutConstraint?
    
    open var imageView: UIImageView?
    open var titleLabel: UILabel?
    open var descriptionLabel: UILabel?
    open var customViewContainer: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCustomView(_ customView: UIView?) {
        guard let cv = customViewContainer else { return }
        guard let v = customView else { return }
        v.translatesAutoresizingMaskIntoConstraints = false
        customViewContainer?.addSubview(v)
        if #available(iOS 9.0, *) {
            NSLayoutConstraint.activate([
                v.centerXAnchor.constraint(equalTo: cv.centerXAnchor),
                v.centerYAnchor.constraint(equalTo: cv.centerYAnchor)
                ])
        } else {
            // Fallback on earlier versions
            v.addConstraint(NSLayoutConstraint(item: cv, attribute: .centerX, relatedBy: .equal, toItem: v, attribute: .centerX, multiplier: 1, constant: 0))
            v.addConstraint(NSLayoutConstraint(item: cv, attribute: .centerY, relatedBy: .equal, toItem: v, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
}

// MARK: public

extension OnboardingContentViewItem {

    class func itemOnView(_ view: UIView) -> OnboardingContentViewItem {
        let item = Init(OnboardingContentViewItem(frame: CGRect.zero)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(item)

        // add constraints
        item >>>- {
            $0.attribute = .height
            $0.constant = 10000
            $0.relation = .lessThanOrEqual
            return
        }

        for attribute in [NSLayoutConstraint.Attribute.leading, NSLayoutConstraint.Attribute.trailing] {
            (view, item) >>>- {
                $0.attribute = attribute
                return
            }
        }

        for attribute in [NSLayoutConstraint.Attribute.centerX, NSLayoutConstraint.Attribute.centerY] {
            (view, item) >>>- {
                $0.attribute = attribute
                return
            }
        }

        return item
    }
}

// MARK: create

private extension OnboardingContentViewItem {

    
    
    func commonInit() {

        let titleLabel = createTitleLabel(self)
        let descriptionLabel = createDescriptionLabel(self)
        let imageView = createImage(self)
        let customViewContainer = createCustomViewContainer(self)

        // added constraints
        titleCenterConstraint = (self, titleLabel, imageView) >>>- {
            $0.attribute = .top
            $0.secondAttribute = .bottom
            $0.constant = 50
            return
        }
        (self, descriptionLabel, titleLabel) >>>- {
            $0.attribute = .top
            $0.secondAttribute = .bottom
            $0.constant = 10
            return
        }
        (self, customViewContainer, descriptionLabel) >>>- {
            $0.attribute = .top
            $0.secondAttribute = .bottom
            $0.constant = 10
        }
        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
        self.imageView = imageView
        self.customViewContainer = customViewContainer
    }

    func createTitleLabel(_ onView: UIView) -> UILabel {
        let label = Init(createLabel()) {
            $0.font = UIFont(name: "Nunito-Bold", size: 36)
        }
        onView.addSubview(label)

        // add constraints
        label >>>- {
            $0.attribute = .height
            $0.constant = 10000
            $0.relation = .lessThanOrEqual
            return
        }

        for attribute in [NSLayoutConstraint.Attribute.centerX, NSLayoutConstraint.Attribute.leading, NSLayoutConstraint.Attribute.trailing] {
            (onView, label) >>>- {
                $0.attribute = attribute
                return
            }
        }
        return label
    }

    func createDescriptionLabel(_ onView: UIView) -> UILabel {
        let label = Init(createLabel()) {
            $0.font = UIFont(name: "OpenSans-Regular", size: 14)
            $0.numberOfLines = 0
        }
        onView.addSubview(label)

        // add constraints
        label >>>- {
            $0.attribute = .height
            $0.constant = 10000
            $0.relation = .lessThanOrEqual
            return
        }

        for (attribute, constant) in [(NSLayoutConstraint.Attribute.leading, 30), (NSLayoutConstraint.Attribute.trailing, -30)] {
            (onView, label) >>>- {
                $0.attribute = attribute
                $0.constant = CGFloat(constant)
                return
            }
        }

        (onView, label) >>>- { $0.attribute = .centerX; return }
//        descriptionBottomConstraint = (onView, label) >>>- { $0.attribute = .bottom; $0.constant = -60; return }

        return label
    }
    
    func createCustomViewContainer(_ onView: UIView) -> UIView {
        let view = Init(createCustomViewContainer()) {_ in
            
        }
        onView.addSubview(view)

        view >>>- {
            $0.attribute = .height
            $0.constant = 50
            $0.relation = .equal
            return
        }
        for (attribute, constant) in [(NSLayoutConstraint.Attribute.leading, 30), (NSLayoutConstraint.Attribute.trailing, -30)] {
            (onView, view) >>>- {
                $0.attribute = attribute
                $0.constant = CGFloat(constant)
                return
            }
        }
        
        (onView, view) >>>- { $0.attribute = .centerX; return }
        descriptionBottomConstraint = (onView, view) >>>- { $0.attribute = .bottom; return }
        
        return view
    }
    
    
    func createLabel() -> UILabel {
        return Init(UILabel(frame: CGRect.zero)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
            $0.textColor = .white
        }
    }
    
    func createCustomViewContainer() -> UIView {
        return Init(UIView(frame: CGRect.zero)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func createImage(_ onView: UIView) -> UIImageView {
        let imageView = Init(UIImageView(frame: CGRect.zero)) {
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        onView.addSubview(imageView)

        // add constratints
        informationImageWidthConstraint = imageView >>>- {
            $0.attribute = NSLayoutConstraint.Attribute.width
            $0.constant = 280
            return
        }
        
        informationImageHeightConstraint = imageView >>>- {
            $0.attribute = NSLayoutConstraint.Attribute.height
            $0.constant = 280
            return
        }

        for attribute in [NSLayoutConstraint.Attribute.centerX, NSLayoutConstraint.Attribute.top] {
            (onView, imageView) >>>- { $0.attribute = attribute; return }
        }

        return imageView
    }
}
