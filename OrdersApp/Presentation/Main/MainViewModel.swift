import Foundation

final class MainViewModel {

    private let ordersService: OrdersServiceProtocol

    private(set) var orders: [Order] = []
    var onOrdersChanged: (() -> Void)?
    var onSelectOrder: ((Order) -> Void)?

    init(ordersService: OrdersServiceProtocol) {
        self.ordersService = ordersService
    }

    func load() {
        orders = ordersService.fetchOrders()
        onOrdersChanged?()
    }

    func didSelectRow(at index: Int) {
        guard orders.indices.contains(index) else { return }
        onSelectOrder?(orders[index])
    }
}
