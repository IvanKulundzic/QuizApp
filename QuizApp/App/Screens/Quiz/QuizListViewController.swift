import UIKit
import Combine
import Factory

final class QuizListViewController: UIViewController {

  private struct Constants {

        static let topMargin = 20
        static let horizontalMargin = 32

    }

    @Injected(QuizContainer.quizListViewModel) private var quizListViewModel
    private var cancellables = Set<AnyCancellable>()
    private var categoryCollectionView: UICollectionView!
    private var quizCollectionView: UICollectionView!
    private var emptyStateView: UIView!
    private var getQuizButton: UIButton!

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
        fetchQuizzes()
    }

    func fetchQuizzes() {
        quizListViewModel.fetchAllQuizes {
            DispatchQueue.main.async {
                self.quizCollectionView.reloadData()
            }
        }
    }

}

// MARK: - UICollectionViewDataSource methods
extension QuizListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryCollectionView {
            return 1
        } else {
            let sections = Dictionary(grouping: quizListViewModel.quizzes) { $0.category }

            return sections.keys.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return quizListViewModel.categories.count
        } else {
            let category = quizListViewModel.categories[section + 1]
            let sections = Dictionary(grouping: quizListViewModel.quizzes) { $0.category }
            let quizzesCount = sections[category]?.count ?? 0
            return quizzesCount
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
            cell.set(for: category)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: QuizCell.reuseIdentifier,
                for: indexPath
            ) as? QuizCell else { fatalError() }

            let sections = Dictionary(grouping: quizListViewModel.quizzes) { $0.category }
            let category = quizListViewModel.categories[indexPath.section + 1]
            let section = sections[category]

            guard let quiz = section?[indexPath.item] else { return cell }

            cell.set(for: quiz)
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath)
    -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: QuizSectionHeaderView.reuseIdentifier,
                                                  for: indexPath) as? QuizSectionHeaderView else { fatalError() }

            let category = quizListViewModel.categories[indexPath.section + 1]

            headerView.set(for: category)
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension QuizListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let category = quizListViewModel.categories[indexPath.item]
            let categoryModel = CategoryModel(from: category)
            quizListViewModel.fetchQuiz(for: categoryModel) {
                self.quizCollectionView.reloadData()
            }
        } else {
            let quiz = quizListViewModel.quizzes[indexPath.item]
            quizListViewModel.goToQuizDetails(quiz: quiz)
        }
    }

}

// MARK: - ConstructViewsProtocol methods
extension QuizListViewController: ConstructViewsProtocol {

    func createViews() {
        emptyStateView = EmptyStateView()
        view.addSubview(emptyStateView)

        categoryCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateCategoryLayout())
        view.addSubview(categoryCollectionView)

        quizCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateQuizLayout())
        view.addSubview(quizCollectionView)

        getQuizButton = UIButton()
        view.addSubview(getQuizButton)
    }

    func styleViews() {
        view.applyGradientWith([UIColor.loginBackgroundTop.cgColor, UIColor.loginBackgroundBottom.cgColor])
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Fonts.sourceSansProBold24.font
        ]

        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        quizCollectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.reuseIdentifier)
        quizCollectionView.register(
            QuizSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: QuizSectionHeaderView.reuseIdentifier)

        categoryCollectionView.backgroundColor = .clear

        quizCollectionView.backgroundColor = .clear

        emptyStateView.isHidden = true

        getQuizButton.setTitle("Get Quiz", for: .normal)
        getQuizButton.setTitleColor(.loginPurple, for: .normal)
        getQuizButton.titleLabel?.font = Fonts.sourceSansProBold16.font
        getQuizButton.backgroundColor = .white
        getQuizButton.layer.cornerRadius = 22
        getQuizButton.isHidden = true
        getQuizButton.addTarget(self, action: #selector(getQuizButtonTapped), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(25)
        }

        quizCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        emptyStateView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
            $0.width.equalTo(250)
        }

        getQuizButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.topMargin)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
            $0.height.equalTo(44)
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

    func setupSections() {}

    func bindViewModel() {
        quizListViewModel
            .$quizzes
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.quizCollectionView.reloadData()
                self.categoryCollectionView.reloadData()
            }
            .store(in: &cancellables)

        quizListViewModel
            .$hideEmptyStateView
            .sink { [weak self] isHidden in
                guard let self = self else { return }

                self.emptyStateView.isHidden = isHidden
                self.getQuizButton.isHidden = isHidden
                self.categoryCollectionView.isHidden = !isHidden
            }
            .store(in: &cancellables)
    }

    func generateQuizLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let quizItem = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(143))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [quizItem])
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 20,
            bottom: 0,
            trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10)
        section.boundarySupplementaryItems = [header]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func generateCategoryLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(150),
            heightDimension: .fractionalHeight(1.0))
        let categoryItem = NSCollectionLayoutItem(layoutSize: itemSize)
        categoryItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .some(.fixed(10)),
            top: nil,
            trailing: .some(.fixed(10)),
            bottom: nil)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(150),
            heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [categoryItem])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    @objc func getQuizButtonTapped() {
        quizListViewModel.fetchAllQuizes {
            DispatchQueue.main.async {
                self.quizCollectionView.reloadData()
            }
        }
    }

}
