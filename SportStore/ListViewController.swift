import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productArray: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getProducts()
    }
    
    func getProducts() {
        let url = URL(string: "https://apiwlad2.herokuapp.com/products")!
        URLSession.shared.dataTask(with: url){
            data,_,_ in
            if let data = data {
                if let json = try? JSONDecoder().decode([Product].self, from: data) {
                    for newProduct in json {
                        self.productArray.append(newProduct)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }.resume()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseIdentifier, for: indexPath) as? MyTableViewCell else {
            fatalError("Cannot create the cell")
        }
        
        cell.nomeProduto.text = productArray[indexPath.row].name
        cell.precoProduto.text = "R$\(productArray[indexPath.row].price)"
        getImage(urlString: productArray[indexPath.row].img, imageView: cell.imagemProduto)
        
        return cell
    }
    
    func getImage(urlString: String, imageView: UIImageView) {
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = productArray[indexPath.row]
        let detailViewController = self.storyboard!.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        detailViewController?.selectedProduct = selectedProduct
        self.present(detailViewController!, animated: true, completion: nil)
    }
}

struct Product: Codable {
    var id: Int
    var name: String
    var price: Float
    var img: String
}
