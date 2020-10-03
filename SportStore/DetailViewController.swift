import UIKit

class DetailViewController: UIViewController {
    
    var selectedProduct: Product? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedProduct?.name
        priceLabel.text = "R$ \(selectedProduct!.price)"
        downloadImagem(imageURL: selectedProduct!.img, imageView: productImage)
    }
    
    func downloadImagem(imageURL: String, imageView: UIImageView) {
        let url = URL(string: imageURL)!
        URLSession.shared.dataTask(with: url) { data,_,_ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
