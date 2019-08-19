//
//  CategoryVC.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 14/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var controller: UserController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = UserController()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")

    }
}

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller?.numberOfRowsCategory() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {return UICollectionViewCell()}
        let selectedCategory = UserDefaults.standard.integer(forKey: TypeUserSettings.categoryIndex.rawValue)
        cell.setupCell(textLabel: controller?.loadCategoryName(index: indexPath.item) ?? "", isSelected: selectedCategory == indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        cell.checkMark.checked = !cell.checkMark.checked
         let categoryName = controller?.loadCategoryISO(index: indexPath.item)
        UserDefaults.standard.set(categoryName, forKey: TypeUserSettings.category.rawValue)
        UserDefaults.standard.set(indexPath.item, forKey: TypeUserSettings.categoryIndex.rawValue)
        NotificationCenter.default.post(name: Notification.Name("UserChangedValue"), object: nil)
        collectionView.reloadData()
    }
}
