import UIKit

final class MainViewController: UIViewController {

    private let viewModel: MainViewModel
    var onNext: ((Order) -> Void)?

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Orders"

        setupTable()
        bindViewModel()
        viewModel.load()
    }

    private func setupTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func bindViewModel() {
        viewModel.onOrdersChanged = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.onSelectOrder = { [weak self] order in
            self?.onNext?(order)   // отдаём событие координатору
        }
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orders.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let order = viewModel.orders[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = order.title
        content.secondaryText = "ID: \(order.id)"
        cell.contentConfiguration = content

        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath.row)
    }
}
