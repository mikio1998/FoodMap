//
//  EditSavedStoneViewController.swift
//  Snacks
//
//  Created by Mikio Nakata on 4/18/20.
//  Copyright © 2020 Mikio Nakata. All rights reserved.
//

import UIKit



class EditSavedStoneViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var stoneData: [Stone] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension EditSavedStoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Stone data in array form. 
        let stone = [
            stoneData[0].name,
            stoneData[0].description,
            stoneData[0].郵便番号,
            stoneData[0].都道府県,
            stoneData[0].市区町村,
            stoneData[0].番地,
            stoneData[0].other]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Edit Saved Stone Text Cell", for: indexPath) as! EditSavedStoneTextCell
        
        
        cell.setTextFieldText(text: stone[indexPath.row])
        
        
        
        return cell
    }
    
    
}

extension EditSavedStoneViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let images = ["stonepic1", "stonepic2", "stonepic3", "stonepic4", "stonepic5"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Stone Image Cell", for: indexPath) as! EditSavedStoneCollectionViewCell
        cell.setImage(image: images[indexPath.row])
        
        return cell
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    
}

extension EditSavedStoneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
