import UIKit

class MyTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: MyTableViewCell.self)
    
    @IBOutlet weak var imagemProduto: UIImageView!
    @IBOutlet weak var nomeProduto: UILabel!
    @IBOutlet weak var precoProduto: UILabel!
}
