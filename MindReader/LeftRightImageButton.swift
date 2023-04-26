//
//  LeftRightImageButton.swift
//  MindReader
//
//  Created by 曾思琦 on 2023/4/14.
//

import UIKit

@IBDesignable
class LeftRightImageButton: UIButton {
    
    private let leftImageView = UIImageView()
    private let rightImageView = UIImageView()

    @IBInspectable var leftImage: UIImage? {
        didSet {
            leftImageView.image = leftImage
            setNeedsLayout()
        }
    }

    @IBInspectable var rightImage: UIImage? {
        didSet {
            rightImageView.image = rightImage
            setNeedsLayout()
        }
    }

    @IBInspectable var titleText: String? {
        didSet {
            setTitle(titleText, for: .normal)
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageViews()
    }

    private func setupImageViews() {
        let labelHeight = titleLabel!.intrinsicContentSize.height
        leftImageView.frame.size = CGSize(width: labelHeight, height: labelHeight)
        rightImageView.frame.size = CGSize(width: labelHeight, height: labelHeight)
        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit
        addSubview(leftImageView)
        addSubview(rightImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let titleLabel = titleLabel else {
            return
        }

        let verticalSpacing: CGFloat = 7
        let horizontalSpacing: CGFloat = 20
        let imageSize: CGFloat = bounds.height - verticalSpacing * 2
        let totalWidth = imageSize * 2 + horizontalSpacing * 3 + titleLabel.intrinsicContentSize.width
        let titleX = (bounds.width - totalWidth) / 2 + imageSize + verticalSpacing

        leftImageView.frame = CGRect(x: (bounds.width - totalWidth) / 2 - horizontalSpacing * 2, y: verticalSpacing, width: imageSize, height: imageSize)

        rightImageView.frame = CGRect(x: leftImageView.frame.maxX + horizontalSpacing * 4 + titleLabel.intrinsicContentSize.width, y: verticalSpacing, width: imageSize, height: imageSize)

        titleLabel.frame = CGRect(x: titleX, y: 0, width: titleLabel.intrinsicContentSize.width + horizontalSpacing, height: bounds.height)
    }
}
