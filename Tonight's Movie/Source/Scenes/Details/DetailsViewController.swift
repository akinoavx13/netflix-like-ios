//
//  DetailsViewController.swift
//  Tonight's Movie
//
//  Créé par Maxime Mahéo en juillet 2018 - droits afférents à ce code cédés, à titre exclusif, à TAKTIK® S.A. de droit belge le 31 mars 2021 qui dispose à présent du ©.
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
    
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.alpha = 0
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
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.setTitleColor(Colors.white, for: .normal)
            addButton.backgroundColor = Colors.red
            addButton.layer.cornerRadius = 2
            addButton.titleLabel?.font = Fonts.smallBold
            addButton.alpha = 0
            addButton.tintColor = Colors.white
            addButton.imageView?.contentMode = .scaleAspectFit
            addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
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
    
    @IBOutlet weak var trailerTitleLabel: UILabel! {
        didSet {
            trailerTitleLabel.text = Translation.Details.trailer
            trailerTitleLabel.textColor = Colors.white
            trailerTitleLabel.font = Fonts.large
            trailerTitleLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var trailerWebView: UIWebView! {
        didSet {
            trailerWebView.backgroundColor = Colors.black
            trailerWebView.scrollView.isScrollEnabled = false
            trailerWebView.scrollView.bounces = false
            trailerWebView.isOpaque = false
            trailerWebView.alpha = 0
            trailerWebView.scalesPageToFit = false
        }
    }
    
    @IBOutlet weak var trailerWebViewHeightConstraint: NSLayoutConstraint! {
        didSet {
            trailerWebViewHeightConstraint.constant = 0
        }
    }
    
    @IBOutlet weak var recommendationsTitleLabel: UILabel! {
        didSet {
            recommendationsTitleLabel.text = Translation.Details.recommendations
            recommendationsTitleLabel.textColor = Colors.white
            recommendationsTitleLabel.font = Fonts.large
            recommendationsTitleLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var recommendationsContenairView: UIView! {
        didSet {
            recommendationsContenairView.alpha = 0
        }
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        presenter.viewCreated()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        pictureImageView.kf.cancelDownloadTask()
        backgroundImageView.kf.cancelDownloadTask()
        trailerWebView.stopLoading()
        
        presenter.viewWillDisappear()
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
    @IBAction func addButtonTapped(_ sender: Any) {
        presenter.addButtonTapped()
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
        
        UIView.animate(withDuration: Style.Animation.duration) {
            self.dateLabel.text = displayModel.date
            self.durationLabel.text = displayModel.duration
            self.configureMarkLabel(voteAverage: displayModel.mark)
            self.overviewLabel.text = displayModel.overview
            self.pictureImageView.alpha = 1
            self.title = displayModel.title
            
            self.view.layoutIfNeeded()
        }
    }
    
    func display(_ displayModel: Details.DisplayData.IsItemSaved) {
        if displayModel.isSaved {
            UIView.animate(withDuration: Style.Animation.duration) {
                self.addButton.setTitle(Translation.Details.removeFromList, for: .normal)
                self.addButton.alpha = 1
                self.addButton.setImage(nil, for: .normal)
                
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: Style.Animation.duration) {
                self.addButton.setTitle(Translation.Details.addToList, for: .normal)
                self.addButton.alpha = 1
                self.addButton.setImage(Icons.bookmark, for: .normal)
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func display(_ displayModel: Details.DisplayData.Trailer) {
        if let trailerUrl = URL(string: displayModel.url) {
            trailerWebView.loadRequest(URLRequest(url: trailerUrl))
            
            UIView.animate(withDuration: Style.Animation.duration) {
                self.trailerTitleLabel.alpha = 1
                self.trailerWebView.alpha = 1
                self.trailerWebViewHeightConstraint.constant = UIScreen.main.bounds.width * 0.9
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func display(_ displayModel: Details.DisplayData.Recommendations) {
        presenter.showRecommendations(with: self, into: recommendationsContenairView)
        
        UIView.animate(withDuration: Style.Animation.duration) {
            self.recommendationsTitleLabel.alpha = 1
            self.recommendationsContenairView.alpha = 1
            
            self.view.layoutIfNeeded()
        }
    }
    
    func display(_ displayModel: Details.DisplayData.Error) {
        showAlertError(message: displayModel.errorMessage)
    }
}
