import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
//        toggleButtons()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
//        toggleButtons()
    }
    
//    private var correctAnswers: Int = 0
//    private var questionFactory: QuestionFactoryProtocol?
//    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenter?
//    private var statisticService: StatisticService?
    private var feedback = UINotificationFeedbackGenerator()
    private var presenter: MovieQuizPresenter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieQuizPresenter(viewController: self)
        imageView.layer.cornerRadius = 20
//        statisticService = StatisticServiceImplementation()
//        showLoadingIndicator()
    }

    // MARK: - Private functions
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }

    func show(quiz result: QuizResultsViewModel) {
        let message = presenter.makeResultsMessage()
        
        let alertPresenter = AlertModel(title: result.title,
                                        message: message,
                                        buttonText: result.buttonText,
                                        completion: { [weak self] in
            guard let self = self else { return }
            
            self.presenter.restartGame()
        })
        
        let alert = AlertPresenter()
        alert.showAlert(view: self, alert: alertPresenter)
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
//        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        feedback.prepare()
        feedback.notificationOccurred(isCorrectAnswer ? .success : .error)
    }
    
    func toggleButtons () {
        noButton.isEnabled.toggle()
        yesButton.isEnabled.toggle()
    }

    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let networkErrormodel = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать еще раз",
            completion: { [weak self] in
                guard let self = self else { return }
                
                self.presenter.restartGame()
            })
        alertPresenter?.showAlert(view: self, alert: networkErrormodel)
    }
}

//extension MovieQuizViewController: QuestionFactoryDelegate {
//    func didLoadDataFromServer() {
//        activityIndicator.isHidden = true
//        questionFactory?.requestNextQuestion()
//    }
    
//    func didFailToLoadData(with error: Error) {
//        showNetworkError(message: error.localizedDescription)
//    }
//}
