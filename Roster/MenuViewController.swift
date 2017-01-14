//
//  MenuViewController.swift
//  Roster
//
//  Created by Ty Schultz on 11/6/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
import ZFDragableModalTransition

class MenuViewController: UIViewController, IGListAdapterDataSource, UIScrollViewDelegate {
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var names : [Any] = []
    
    var inPlayPlayers : Results<Player>?
    var benchPlayers : Results<Player>?
    
    var realm : Realm?
    var firstSection = true
    
    var countDown = 1.0
    var countDownTimer : Timer?
    
    var controlView : ControlsView?
    
    var inPlay = true
    
    fileprivate let PLUSMINUS = "PLUSMINUS"
    fileprivate let ADDPLAYER = "ADDPLAYER"
    fileprivate let PAGEHEADER = "PAGEHEADER"
    
    fileprivate let UPDATETIME = 0.3
    
    var animator : ZFModalTransitionAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navBar = self.navigationController?.navigationBar {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
            navBar.barTintColor = UIColor.white
            self.title = "Game 1"
        }
        
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 28, width: self.view.frame.width, height: self.view.frame.height+100))
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 8.0
        self.view.addSubview(backgroundView)
        self.view.sendSubview(toBack: backgroundView)
        
        self.view.backgroundColor = UIColor.clear
        self.collectionView.backgroundColor = UIColor.clear
        
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        names = ["Tyler","Nick","Zelda","Johnny","JT","Name","May","App","Game"]
        
        realm = try! Realm()
        //        for name in names {
        //            let p = Player()
        //            p.name = name as! String
        //            p.time = 0.0
        //            p.inPlay = true
        //            p.plusMinus = 0
        //            try! realm!.write {
        //                realm!.add(p, update: true)
        //            }
        //        }
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        self.collectionView.contentInset = UIEdgeInsets(top: 28, left: 0, bottom: 0, right: 0)
        self.collectionView.layer.masksToBounds = true
        self.collectionView.layer.cornerRadius = 8.0

    }
    
    override func viewWillLayoutSubviews() {
        let test = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        test.backgroundColor = TSBlue
        self.view.addSubview(test)
        self.view.sendSubview(toBack: test)
    }
    
    
    func presentDetailView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) //if bundle is nil the main bundle will be used
        
        //        self.animator =  ZFModalTransitionAnimator(modalViewController: inGameDetails)
        //        self.animator!.isDragable = true
        //        self.animator!.direction = .bottom
        //        self.animator!.behindViewScale = 0.94
        //        self.animator!.behindViewAlpha = 0.8
        //        self.animator!.transitionDuration = 0.7
        //        inGameDetails.transitioningDelegate = self.animator;
        //
        //        inGameDetails.modalPresentationStyle = .custom;
        //        self.present(inGameDetails, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPlayers()
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        self.collectionView.layer.cornerRadius = 0.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        self.collectionView.layer.cornerRadius = 8.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func getPlayers () {
        if let realm = realm {
            inPlayPlayers = realm.objects(Player.self).filter("inPlay = true")
            benchPlayers = realm.objects(Player.self).filter("inPlay = false").sorted(byProperty: "totalTime", ascending: false)
        }
    }
    
    func organizeItems() -> [Any] {
        var e : [Any] = []
        if let inPlayPlayers = inPlayPlayers, let benchPlayers = benchPlayers {
            e.append("In Play")
            e.append(resultToList(results: inPlayPlayers))
            //            e.append(PLUSMINUS)
            e.append("Bench")
            e.append(resultToList(results: benchPlayers))
        }
        return e
    }
    
    func resultToList(results : Results<Player>) -> [Player] {
        var players : [Player] = []
        for player in results {
            players.append(player)
        }
        return players
    }
    
    func minusAmount () {
        self.changePlusMinus(amount: -1)
    }
    
    func plusAmount () {
        self.changePlusMinus(amount: 1)
    }
    
    func changePlusMinus(amount : Int) {
        guard inPlayPlayers == inPlayPlayers else { return }
        
        let e = self.adapter.sectionController(for: 2)
        e?.viewController?.view.backgroundColor = TSBlue
        
        if amount > 0 {
            try! realm?.write {
                for player in inPlayPlayers! {
                    player.plusTotal += amount
                }
            }
        }else {
            try! realm?.write {
                for player in inPlayPlayers! {
                    player.minusTotal += amount
                }
            }
        }
        
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.white.cgColor
        animation.toValue = amount > 0 ? TSGreen.cgColor : TSOrange.cgColor
        animation.autoreverses = true
        animation.duration = 0.3
        self.controlView?.layer.add(animation, forKey: "newBackgroundColor")
        
        
        self.adapter.reloadData(completion: nil)
    }
    
    func cellTapped() {
        countDownTimer?.invalidate()
        countDown = UPDATETIME
        countDownTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.countDown -= 0.1
            print(self.countDown)
            if self.countDown <= 0 {
                self.adapter.performUpdates(animated: true, completion: nil)
                timer.invalidate()
            }
        }
    }
    
    //MARK: IGListAdapterDataSource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        let items: [IGListDiffable] = organizeItems() as! [IGListDiffable]
        return items
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let obj = object as? String {
            switch obj {
            case PAGEHEADER:
                return PageHeaderController()
            case ADDPLAYER:
                return AddPlayerSectionController()
            default:
                return SectionHeaderController()
            }
        }else {
            if inPlay {
                inPlay = false
                return InPlaySectionController()
            }else {
                inPlay = true 
                return BenchCellSectionController()
            }
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
    
    
    
    
}
