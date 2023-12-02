//
//  IntroViewController.swift
//  HealthApp
//
//  Created by Hai Nam on 30/11/2023.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet private weak var introCollectionView: UICollectionView!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var topLbl: UILabel!
    @IBOutlet private weak var bottomLbl: UILabel!
    @IBOutlet private var stepper: [UIView]!
    
    private var photos: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introCollectionView.dataSource = self
        introCollectionView.delegate = self
        introCollectionView.isPagingEnabled = true
        introCollectionView.showsHorizontalScrollIndicator = false
        
        setTranslucentNavBar()
        
        setUpButtonFont()

        photos = imagePhotos(imageNames: K.IntroVCConstant.PhotoArray)
        let nib = UINib(nibName: K.IntroVCConstant.CellNibName, bundle: nil)
        introCollectionView.register(nib, forCellWithReuseIdentifier: K.IntroVCConstant.CellId)
        
    }
    
    func setTranslucentNavBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        introCollectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setUpButtonFont() {
        topLbl.font = GetFont.nunitoBold(24)
        bottomLbl.font = GetFont.nunitoRegular(14)
        logInButton.titleLabel?.font = GetFont.nunitoBold(15)
        signUpButton.titleLabel?.font = GetFont.nunitoBold(15)
        
        configUpdateButton(logInButton)
        configUpdateButton(signUpButton)
        
        signUpButton.layer.borderColor = UIColor(red: 0.14, green: 0.16, blue: 0.38, alpha: 1).cgColor
    }
    
    func configUpdateButton(_ button: UIButton) {
        var newConfiguration = button.configuration
        newConfiguration?.attributedTitle?.font = GetFont.nunitoBold(15)
        button.configuration = newConfiguration
    }
    
    func setNewStepper(withIndex num: Int) {
        for i in 0...2 {
            stepper[i].backgroundColor = (stepper[i].tag == num) ? UIColor(named: K.Color.darkGreen) : UIColor(named: K.Color.lightGreen)
        }
    }
    
    func imagePhotos(imageNames: [String]) -> [UIImage] {
        var res : [UIImage] = []
        for str in imageNames {
            res.append(UIImage(named: str)!)
        }
        return res
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let destinationVC = SignUpViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
//MARK: - Set up Intro Collection View Data and Delegate
extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.IntroVCConstant.CellId, for: indexPath) as! IntroCollectionViewCell
        cell.imageView.image = photos![indexPath.row]
        return cell
    }
    
}
//MARK: - Collection Delegate FlowLayout
extension IntroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Completion Handler of CollectionView when complete scroll to new image
extension IntroViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: introCollectionView.contentOffset, size: introCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = introCollectionView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.row
            setNewStepper(withIndex: currentIndex)
        }
    }
    
}
