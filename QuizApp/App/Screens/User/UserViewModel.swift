import Foundation

final class UserViewModel {

    @Published var username = ""
    @Published var name = ""

    private let userUseCase: UserUseCaseProtocol

    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }

    func getUserInfo() {
        Task(priority: .background) {
            let userInfo = await userUseCase.getUserInfo()
            username = userInfo.username
            name = userInfo.name
        }

    }

}
