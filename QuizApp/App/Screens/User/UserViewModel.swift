import Foundation
import Combine

final class UserViewModel {

    @Published var username = ""
    @Published var name = ""
    var errorMessage = PassthroughSubject<String, Never>()

    private let userUseCase: UserUseCaseProtocol

    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
    }

    func getUserInfo() {
        Task {
            do {
                let userInfo = try await userUseCase.userInfo
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.username = userInfo.username
                    self.name = userInfo.name
                }
            } catch let error {
                handle(error: error.localizedDescription)
            }
        }
    }

    func update(_ name: String) {
        Task {
            await userUseCase.update(name: name)
        }
    }

}

// MARK: - Private methods
private extension UserViewModel {

    func handle(error: String) {
        errorMessage.send(error)
    }
}
