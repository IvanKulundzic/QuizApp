import UIKit
import Combine

final class QuizListViewController: UIViewController {

    private var categoryCollectionView: UICollectionView!
    private var quizCollectionView: UICollectionView!
    private var emptyStateView: UIView!
    private var cancellables = Set<AnyCancellable>()
    private let quizListViewModel: QuizListViewModel

    init(quizViewModel: QuizListViewModel) {
        self.quizListViewModel = quizViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayoutForViews()
        setupDelegateAndDataSource()
        bindViewModel()
        quizListViewModel.fetchAllQuizes()
        quizListViewModel.fetchCategories()
    }

}

// MARK: - UICollectionViewDataSource methods
extension QuizListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return quizListViewModel.categories.count
        } else {
            return quizListViewModel.quizes.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.reuseIdentifier,
                for: indexPath
            ) as? CategoryCell else { fatalError() }
            let category = quizListViewModel.categories[indexPath.item]
            let firstCategory = quizListViewModel.categories.first
            quizListViewModel.fetchQuiz(for: firstCategory?.rawValue ?? "")
            cell.set(for: category)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizCell.reuseIdentifier,
                for: indexPath
            ) as? QuizCell else { fatalError() }
            let quiz = quizListViewModel.quizes[indexPath.item]
            cell.set(for: quiz)
            return cell
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension QuizListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let category = quizListViewModel.categories[indexPath.item].rawValue
            quizListViewModel.fetchQuiz(for: category)
        }
    }

}

// MARK: - ConstructViewsProtocol methods
extension QuizListViewController: ConstructViewsProtocol {

    func createViews() {
        emptyStateView = EmptyStateView()
        view.addSubview(emptyStateView)

        categoryCollectionView = UICollectionView.makeCollectionView(direction: .horizontal, spacing: 10)
        view.addSubview(categoryCollectionView)

        quizCollectionView = UICollectionView.makeCollectionView(direction: .vertical, spacing: 15)
        view.addSubview(quizCollectionView)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Fonts.sourceSansProBold24.font
        ]

        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        quizCollectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.reuseIdentifier)

        categoryCollectionView.backgroundColor = .clear
        quizCollectionView.backgroundColor = .clear

        emptyStateView.isHidden = true
    }

    func defineLayoutForViews() {
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(25)
        }

        quizCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        emptyStateView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
            $0.width.equalTo(250)
        }
    }

}

// MARK: - Private methods
private extension QuizListViewController {

    func setupTabBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProBold24.font

        tabBarController?.navigationItem.titleView?.isHidden = false
        tabBarController?.navigationItem.titleView = titleLabel

        tabBarItem.title = "Quiz"
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        tabBarItem.image = UIImage.quizIcon?.withRenderingMode(.alwaysTemplate)
    }

    func setupDelegateAndDataSource() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self

        quizCollectionView.delegate = self
        quizCollectionView.dataSource = self
    }

    func bindViewModel() {
        quizListViewModel
            .$quizes
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.quizCollectionView.reloadData()
            }
            .store(in: &cancellables)

        quizListViewModel
            .$categories
            .removeDuplicates()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.categoryCollectionView.reloadData()

            }
            .store(in: &cancellables)
    }

}
