//
//  NewsStoryTableViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import SDWebImage /* 387 */
import UIKit

/// News story tableView cell
final class NewsStoryTableViewCell: UITableViewCell {
    /// Cell identifier
    static let identifier = "NewsStoryTableViewCell" /* 304 */
    
    /// Ideal height of cell
    static let preferredHeight: CGFloat = 140 /* 344 */
    
    /// Cell ViewModel
    struct ViewModel { /* 305 */
        let source: String /* 341 */
        let headline: String /* 341 */
        let dateString: String /* 341 */
        let imageUrl: URL? /* 341 */
        
        init(model: NewsStory) { /* 342 */
            self.source = model.source /* 343 */
            self.headline = model.headline /* 343 */
            self.dateString = .string(from: model.datetime) /* 343 */ /* 373 change "21 Jan"*/
            self.imageUrl = URL(string: model.image) /* 343 */ /* 374 change nil */
        }
    }
    
    ///Source label
    private let sourceLabel: UILabel = { /* 315 */
       let label = UILabel() /* 316 */
        label.font = .systemFont(ofSize: 14, weight: .medium) /* 317 */
        return label /* 318 */
    }()
    
    ///Headline label
    private let headlineLabel: UILabel = { /* 319 */
       let label = UILabel() /* 320 */
        label.font = .systemFont(ofSize: 22, weight: .regular) /* 321 */
        label.numberOfLines = 0 /* 364 */
        return label /* 322 */
    }()
    
    ///Date label
    private let dateLabel: UILabel = { /* 323 */
       let label = UILabel() /* 324 */
        label.textColor = .secondaryLabel /* 363 */
        label.font = .systemFont(ofSize: 14, weight: .light) /* 325 */
        return label /* 326 */
    }()
    
    ///Image View for story
    private let storyImageView: UIImageView = { /* 327 */
        let imageView = UIImageView() /* 328 */
        imageView.backgroundColor = .tertiarySystemBackground /* 357 */
        imageView.clipsToBounds = true /* 329 */
        imageView.contentMode = .scaleAspectFill /* 330 */
        imageView.layer.cornerRadius = 6 /* 331 */
        imageView.layer.masksToBounds = true /* 332 */
        return imageView /* 333 */
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 306 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 307 */
        contentView.backgroundColor = .secondarySystemBackground /* 334 */
        backgroundColor = nil /* 335 */
        addSubviews(sourceLabel, headlineLabel, dateLabel, storyImageView) /* 336 */
    }
    
    required init?(coder: NSCoder) { /* 308 */
        fatalError() /* 309 */
    }
    
    override func layoutSubviews() { /* 310 */
        super.layoutSubviews() /* 311 */
        
        let imageSize: CGFloat = contentView.height/1.4
        storyImageView.frame = CGRect(
            x: contentView.width-imageSize-10,
            y: (contentView.height - imageSize) / 2,
            width: imageSize,
            height: imageSize
        ) /* 356 */
        
        //Layout Labels
        let availableWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 15 /* 359 */
        dateLabel.frame = CGRect(
            x: separatorInset.left,
            y: contentView.height-40,
            width: availableWidth,
            height: 40
        ) /* 358 */
        
        sourceLabel.sizeToFit() /* 362 */
        sourceLabel.frame = CGRect(
            x: separatorInset.left,
            y: 4,
            width: availableWidth,
            height: sourceLabel.height
        ) /* 360 */
        
        headlineLabel.frame = CGRect(
            x: separatorInset.left,
            y: sourceLabel.bottom + 5,
            width: availableWidth,
            height: contentView.height - sourceLabel.bottom - dateLabel.height - 10
        ) /* 361 */
    }
    
    override func prepareForReuse() { /* 312 */
        super.prepareForReuse() /* 313 */
        sourceLabel.text = nil /* 337 */
        headlineLabel.text = nil /* 338 */
        dateLabel.text = nil /* 339 */
        storyImageView.image = nil /* 340 */
    }
    
    /// Configure View
    /// - Parameter viewModel: View ViewModel
    public func configure(with viewModel: ViewModel) { /* 314 */
        headlineLabel.text = viewModel.headline /* 353 */
        sourceLabel.text = viewModel.source /* 355 */
        dateLabel.text = viewModel.dateString /* 354 */
        storyImageView.sd_setImage(with: viewModel.imageUrl, completed: nil) /* 388 */
        //Manually set image
//        storyImageView.setImage(with: viewModel.imageUrl) /* 386 */
    }
}
