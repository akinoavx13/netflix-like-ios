//
//  DetailsViewController.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 08/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Properties -
    private var presenter: DetailsPresenterInput!

    // MARK: - Outlets -
    @IBOutlet weak var contenairView: UIView! {
        didSet {
            contenairView.backgroundColor = Colors.black
        }
    }
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
            closeButton.tintColor = Colors.white
            closeButton.setImage(Icons.close?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    @IBOutlet weak var closeButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.contentMode = .scaleAspectFill
            pictureImageView.clipsToBounds = true
            pictureImageView.dropShadow(offsetX: 4, offsetY: 4, color: UIColor.black, opacity: 1, radius: 4)
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var gradientView: UIView! {
        didSet {
            gradientView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var markLabel: UILabel! {
        didSet {
            markLabel.text = ""
            markLabel.textColor = Colors.grey
            markLabel.font = Fonts.smallHeavy
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = ""
            dateLabel.textColor = Colors.grey
            dateLabel.font = Fonts.small
        }
    }
    
    @IBOutlet weak var durationLabel: UILabel! {
        didSet {
            durationLabel.text = ""
            durationLabel.textColor = Colors.grey
            durationLabel.font = Fonts.small
        }
    }
    
    @IBOutlet weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.text = ""
            overviewLabel.textColor = Colors.white
            overviewLabel.numberOfLines = 0
            overviewLabel.font = Fonts.small
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.black
        closeButtonTopConstraint.constant = UIApplication.shared.statusBarFrame.height
        
        presenter.viewCreated()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        pictureImageView.kf.cancelDownloadTask()
        backgroundImageView.kf.cancelDownloadTask()
    }
    
    // MARK: - Methods -
    class func instantiate(with presenter: DetailsPresenterInput) -> DetailsViewController {
        let name = "\(DetailsViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! DetailsViewController
        viewController.presenter = presenter
        
        return viewController
    }
    
    private func configureMarkLabel(voteAverage: Double) {
        markLabel.text = "\(Translation.Details.mark) \(Int(voteAverage * 10)) %"
        if voteAverage >= 6.5 {
            markLabel.textColor = Colors.green
        } else if voteAverage < 6.5 && voteAverage > 5.0 {
            markLabel.textColor = Colors.orange
        } else {
            markLabel.textColor = Colors.red
        }
    }
    
    // MARK: - Actions -
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        presenter.closeButtonTapped()
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension DetailsViewController: DetailsPresenterOutput {
    func display(_ displayModel: Details.DisplayData.Details) {
        if let pictureURL = URL(string: displayModel.pictureURL) {
            pictureImageView.kf.setImage(with: pictureURL)
        }
        
        if let backgroundURL = URL(string: displayModel.backgroundURL) {
            backgroundImageView.kf.setImage(with: backgroundURL)
        }
        
        gradientView.gradient(colors: [UIColor.clear.cgColor, Colors.black.cgColor])
        
        UIView.animate(withDuration: 0.2) {
            self.dateLabel.text = displayModel.date
            self.durationLabel.text = displayModel.duration
            self.configureMarkLabel(voteAverage: displayModel.mark)

            self.overviewLabel.text = displayModel.overview
            self.view.layoutIfNeeded()
        }
        
    }
    
    func display(_ displayModel: Details.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
