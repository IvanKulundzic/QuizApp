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
        if collectionView == categoryCollectionView {
            return quizViewModel.quizCategories.count
        } else {
            return 4
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

            cell.data = Category(name: quizViewModel.quizCategories[indexPath.item].name)

            if indexPath.item == 0 {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            }

            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizCell.reuseIdentifier,
                for: indexPath
            ) as? QuizCell else { fatalError() }

            cell.data = Category(name: quizViewModel.quizCategories[indexPath.item].name)
            return cell
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension QuizViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == categoryCollectionView {
            return calculateSize(indexPath: indexPath)
        } else {
            return CGSize(width: quizCollectionView.frame.width, height: 143)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.isSelected = true
        }
    }

}

// MARK: - ConstructViewsProtocol methods
extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        emptyStateView = EmptyStateView()
        view.addSubview(emptyStateView)

        categoryCollectionView = UICollectionView.makeCollectionView(direction: .horizontal, spacing: 0)
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
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(30)
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

    func calculateSize(indexPath: IndexPath) -> CGSize {
        let categories = quizViewModel.quizCategories
        let text = categories[indexPath.row].name
        let font = Fonts.sourceSansProBold20.font
        let offset: CGFloat = 10
        let textSize = text.size(withAttributes: [.font: font])
        let width = CGFloat(textSize.width + offset)
        let height = CGFloat(textSize.height)

        return CGSize(width: width, height: height)
    }

}
