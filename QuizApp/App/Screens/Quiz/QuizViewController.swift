import UIKit

final class QuizViewController: UIViewController {

    private var categoryCollectionView: UICollectionView!
    private var quizCollectionView: UICollectionView!
    private var emptyStateView: UIView!
    private let quizViewModel: QuizViewModel

    init(quizViewModel: QuizViewModel) {
        self.quizViewModel = quizViewModel
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
    }

}

// MARK: - UICollectionViewDataSource methods
extension QuizViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizViewModel.quizCategories.count
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

            let category = quizViewModel.quizCategories[indexPath.item]
            cell.set(for: category)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizCell.reuseIdentifier,
                for: indexPath
            ) as? QuizCell else { fatalError() }

            let category = quizViewModel.quizCategories[indexPath.item]
            cell.set(for: category)
            return cell
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension QuizViewController: UICollectionViewDelegateFlowLayout { }

// MARK: - ConstructViewsProtocol methods
extension QuizViewController: ConstructViewsProtocol {

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
            $0.height.equalTo(40)
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
private extension QuizViewController {

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

}
