struct CategoryModel {

    let title: String

    init(from dataModel: CategoryDataModel) {
        self.title = dataModel.title
    }

}
