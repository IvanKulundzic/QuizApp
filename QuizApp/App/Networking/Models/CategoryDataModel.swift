struct CategoryDataModel {

    let title: String

    init(from networkModel: CategoryNetworkModel) {
        self.title = networkModel.rawValue
    }

}
