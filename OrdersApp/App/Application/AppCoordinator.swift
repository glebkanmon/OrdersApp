import UIKit

final class AppCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = MockOrdersService()
        let viewModel = MainViewModel(ordersService: service)
        let vc = MainViewController(viewModel: viewModel)

        vc.onNext = { [weak self] order in
            self?.showDetails(order: order)
        }

        navigationController.setViewControllers([vc], animated: false)
    }

    
    private func showDetails(order: Order) {
        let vc = DetailsViewController(order: order)
        navigationController.pushViewController(vc, animated: true)
    }
}
