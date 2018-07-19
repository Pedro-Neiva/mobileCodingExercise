//
//  EventViewController.swift
//  MobileCodingExercise
//
//  Created by Pedro Neiva Alves on 7/17/18.
//  Copyright © 2018 Pedro Neiva Alves. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    /// Event model
    private var model: EventModel!
    
    private var collectionViewSizeChanged: Bool = false
    private let cellMargin: CGFloat = 10.0
    private let cellHeight: CGFloat = 210.0
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.lock(duration: 0)
        
        setupModel()
        
        setupCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionViewSizeChanged = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if collectionViewSizeChanged {
            collectionView.collectionViewLayout.invalidateLayout()
            
            guard traitCollection.userInterfaceIdiom == .phone else { return }
            
            let remainder = collectionView.contentOffset.y.truncatingRemainder(dividingBy: cellHeight + cellMargin * 2)
            var relativeY = collectionView.contentOffset.y - remainder
            
            if traitCollection.verticalSizeClass == .regular {
                relativeY = relativeY * 2
            } else {
                relativeY = relativeY / 2
                relativeY = relativeY - relativeY.truncatingRemainder(dividingBy: cellHeight + cellMargin * 2)
            }
            
            collectionView.contentOffset = CGPoint(x: 0, y: relativeY + remainder)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if collectionViewSizeChanged {
            collectionViewSizeChanged = false
            collectionView.performBatchUpdates({}, completion: nil)
        }
    }
    
    //MARK: - Setup methods
    private func setupModel() {
        model = EventModel()
        model.asyncDelegate = self
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.minimumInteritemSpacing = cellMargin * 2
        flowLayout.minimumLineSpacing = cellMargin * 2
        flowLayout.sectionInset = UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
    }
}

//MARK: - AsyncDelegate
extension EventViewController: AsyncDelegate {
    func asyncUpdate(response: AsyncResponse) {
        switch response {
        case .success:
            //self.view.unlock()
            collectionView.reloadData()
            print(model)
        case .failure(let error):
            print(error)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension EventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        
        cell.event = model[indexPath.row]
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension EventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat
        
        if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular {
            width = floor((collectionView.frame.size.width - 4.0 * cellMargin) / 2.0)
        } else {
            if traitCollection.verticalSizeClass == .regular {
                width = collectionView.frame.size.width - 2.0 * cellMargin
            } else {
                width = floor((collectionView.frame.size.width - 4.0 * cellMargin) / 2.0)
            }
        }
        
        return CGSize(width: width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EventCollectionViewCell
        
        let remainder = collectionView.contentOffset.y.truncatingRemainder(dividingBy: cellHeight + cellMargin * 2)
        let relativeY = collectionView.contentOffset.y - remainder
        
        print("-----------------------------------\nIndexPath: \(indexPath.row) Content.y:\(collectionView.contentOffset.y) Resto:\(remainder) Inteiro:\(relativeY) Celulas:\(relativeY / (cellHeight + cellMargin * 2))")
        //        print("\(cell.event)")
        print("-----------------------------------")
    }
}
