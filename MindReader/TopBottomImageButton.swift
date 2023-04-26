//
//  TopBottomImageButton.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/15.
//

import UIKit

@IBDesignable
class TopBottomImageButton: UIButton {

//        //MARK: Properties
//
//        @IBInspectable var topImage: UIImage? {
//            didSet {
//                setupImageViews()
//            }
//        }
//
//        @IBInspectable var bottomImage: UIImage? {
//            didSet {
//                setupImageViews()
//            }
//        }
//
//        @IBInspectable var textVertical: String? {
//            didSet {
//                titleLabel?.numberOfLines = 0
//                titleLabel?.textAlignment = .center
//                setupTitleLabel()
//            }
//        }
//
//        //MARK: Private Functions
//
//        private var topImageView: UIImageView?
//        private var bottomImageView: UIImageView?
//
//        private func setupImageViews() {
//            // Remove previous image views
//            topImageView?.removeFromSuperview()
//            bottomImageView?.removeFromSuperview()
//
//            // Add top image view
//            if let topImage = topImage {
//                topImageView = UIImageView(image: topImage)
//                addSubview(topImageView!)
//
//                // Ensure aspect ratio is maintained
//                topImageView?.contentMode = .scaleAspectFit
//            }
//
//            // Add bottom image view
//            if let bottomImage = bottomImage {
//                bottomImageView = UIImageView(image: bottomImage)
//                addSubview(bottomImageView!)
//
//                // Ensure aspect ratio is maintained
//                bottomImageView?.contentMode = .scaleAspectFit
//            }
//
//            // Update image view frames
//            setNeedsLayout()
//        }
    
//        private func setupTitleLabel() {
//            // Create new title label
//            let titleLabel = UILabel()
//            titleLabel.numberOfLines = 0
//            titleLabel.textAlignment = .center
//            titleLabel.text = textVertical
//            titleLabel.sizeToFit()
//
//            // Set new title label as the title label for the button
//            setTitle(nil, for: .normal) // Clear existing title label
//            setAttributedTitle(nil, for: .normal) // Clear attributed title label
//            addSubview(titleLabel)
//            self.titleLabel?.isHidden = true
//
//            // Update title label frame
//            setNeedsLayout()
//        }
    
//        private func setupTitleLabel() {
//            // Create new title label
//            let titleLabel = UILabel()
//            titleLabel.numberOfLines = 0
//            titleLabel.textAlignment = .center
//            titleLabel.lineBreakMode = .byCharWrapping
//            titleLabel.sizeToFit()
//
//            // Split text into an array of characters, and join them with newline characters
//            let lines = textVertical?.map { String($0) } ?? []
//            let text = lines.joined(separator: "\n")
//
//            titleLabel.text = text
//
//            // Set new title label as the title label for the button
//            setTitle(nil, for: .normal) // Clear existing title label
//            setAttributedTitle(nil, for: .normal) // Clear attributed title label
//            addSubview(titleLabel)
//            self.titleLabel?.isHidden = true
//
//            // Update title label frame
//            setNeedsLayout()
//        }
//
//        //MARK: Layout
//
//        override func layoutSubviews() {
//            super.layoutSubviews()
//
//            // Calculate image view frames
//            let imageWidth = bounds.width
//            let imageHeight = bounds.height / 2
//            let topImageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
//            let bottomImageFrame = CGRect(x: 0, y: imageHeight, width: imageWidth, height: imageHeight)
//
//            // Set image view frames
//            topImageView?.frame = topImageFrame
//            bottomImageView?.frame = bottomImageFrame
//
//            // Calculate title label frame
//            let titleLabelHeight = CGFloat((textVertical?.count ?? 0) * 20)
//            let titleLabelWidth = bounds.width
//            let titleLabelFrame = CGRect(x: 0, y: (bounds.height - titleLabelHeight) / 2, width: titleLabelWidth, height: titleLabelHeight)
//
//            // Set title label frame
//            titleLabel?.frame = titleLabelFrame
//        }
    
//        override func layoutSubviews() {
//            super.layoutSubviews()
//
//            // Calculate image view frames
//            let imageWidth = bounds.width
//            let imageHeight = bounds.height / 2
//            let topImageFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
//            let bottomImageFrame = CGRect(x: 0, y: imageHeight, width: imageWidth, height: imageHeight)
//
//            // Set image view frames
//            topImageView?.frame = topImageFrame
//            bottomImageView?.frame = bottomImageFrame
//
//            // Calculate title label frame
//            let titleLabelHeight = titleLabel?.sizeThatFits(bounds.size).height ?? 0
//            let titleLabelWidth = bounds.width
//            let titleLabelFrame = CGRect(x: 0, y: (bounds.height - titleLabelHeight) / 2 + imageHeight / 2, width: titleLabelWidth, height: titleLabelHeight)
//
//            // Set title label frame
//            titleLabel?.frame = titleLabelFrame
//            titleLabel?.center = self.center
//        }
//    }

//        @IBInspectable var topImage: UIImage? {
//            didSet {
//                setupImageViews()
//            }
//        }
//
//        @IBInspectable var bottomImage: UIImage? {
//            didSet {
//                setupImageViews()
//            }
//        }
//
//        @IBInspectable var textString: String? {
//            didSet {
//                setText()
//            }
//        }
//
//        private var topImageView: UIImageView?
//        private var bottomImageView: UIImageView?
//        private var label: UILabel?
//
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            commonInit()
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//            commonInit()
//        }
//
//        private func commonInit() {
//            self.backgroundColor = UIColor.clear
//            self.contentVerticalAlignment = .center
//        }
//
//        override func prepareForInterfaceBuilder() {
//            super.prepareForInterfaceBuilder()
//            setupImageViews()
//            setText()
//        }
//
//        private func setupImageViews() {
//            topImageView?.removeFromSuperview()
//            bottomImageView?.removeFromSuperview()
//
//            if let topImage = topImage {
//                topImageView = UIImageView(image: topImage)
//                addSubview(topImageView!)
//            }
//
//            if let bottomImage = bottomImage {
//                bottomImageView = UIImageView(image: bottomImage)
//                addSubview(bottomImageView!)
//            }
//
//            setNeedsLayout()
//        }
//
//        private func setText() {
//            label?.removeFromSuperview()
//            if let textString = textString {
//                label = UILabel()
//                label?.text = textString
//                label?.textAlignment = .center
//                label?.font = UIFont.systemFont(ofSize: 14)
//                label?.numberOfLines = 0
//                label?.lineBreakMode = .byCharWrapping
//                addSubview(label!)
//                setNeedsLayout()
//            }
//        }
//
//        override func layoutSubviews() {
//            super.layoutSubviews()
//
//            let imageSize = CGSize(width: bounds.width, height: bounds.height/2)
//            let labelSize = CGSize(width: bounds.width, height: bounds.height/2)
//            let labelOrigin = CGPoint(x: 0, y: bounds.height/2)
//
//            topImageView?.frame = CGRect(origin: bounds.origin, size: imageSize)
//            bottomImageView?.frame = CGRect(origin: CGPoint(x: 0, y: bounds.height/2), size: imageSize)
//            label?.frame = CGRect(origin: labelOrigin, size: labelSize)
//        }
        
    // Top image view
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Bottom image view
    private let bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Bottom label
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Image and text padding
    @IBInspectable var padding: CGFloat = 10 {
        didSet {
            setNeedsLayout()
        }
    }

    // Top image
    @IBInspectable var topImage: UIImage? {
        didSet {
            topImageView.image = topImage
            setNeedsLayout()
        }
    }

    // Bottom image
    @IBInspectable var bottomImage: UIImage? {
        didSet {
            bottomImageView.image = bottomImage
            setNeedsLayout()
        }
    }

    // Bottom text
    @IBInspectable var bottomText: String? {
        didSet {
            bottomLabel.text = bottomText
            setNeedsLayout()
        }
    }

    // Setup views
    private func setupViews() {
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            // Top image view constraints
            topImageView.topAnchor.constraint(equalTo: topAnchor),
            topImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -padding * 2),
            
            // Bottom image view constraints
            bottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -padding * 2),
            
            // Bottom label constraints
            bottomLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: padding),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomImageView.topAnchor, constant: -padding),
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set top image view height and aspect ratio
        if let topImage = topImage {
            let aspectRatio = topImage.size.width / topImage.size.height
            let topImageViewHeight = (bounds.width - padding * 2) / aspectRatio
            topImageView.heightAnchor.constraint(equalToConstant: topImageViewHeight).isActive = true
        }
        
        // Set bottom image view height and aspect ratio
        if let bottomImage = bottomImage {
            let aspectRatio = bottomImage.size.width / bottomImage.size.height
            let bottomImageViewHeight = (bounds.width - padding * 2) / aspectRatio
            bottomImageView.heightAnchor.constraint(equalToConstant: bottomImageViewHeight).isActive = true
        }
    }

    // Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}
