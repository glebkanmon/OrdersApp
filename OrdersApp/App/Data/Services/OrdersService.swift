import Foundation

protocol OrdersServiceProtocol {
    func fetchOrders() -> [Order]
}

final class MockOrdersService: OrdersServiceProtocol {
    func fetchOrders() -> [Order] {
        [
            Order(id: "001", title: "Order #001"),
            Order(id: "002", title: "Order #002"),
            Order(id: "003", title: "Order #003"),
        ]
    }
}
