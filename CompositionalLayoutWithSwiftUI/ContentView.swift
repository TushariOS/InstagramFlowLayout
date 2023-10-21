//
//  ContentView.swift
//  CompositionalLayoutWithSwiftUI
//
//  Created by Tushar Jaunjalkar on 11/04/23.
//

import SwiftUI

class FoodViewController: UICollectionViewController {
    init() {
        let layout = FoodViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let categoryHeaderId = "categoryHeaderId"
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            if section == 0 {
                let bannerItemSize = NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let bannerItem = NSCollectionLayoutItem(layoutSize: bannerItemSize)
                bannerItem.contentInsets.trailing = 2
                //bannerItem.contentInsets.bottom = 10
                let bannerGroupSize = NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let bannerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bannerGroupSize, subitems: [bannerItem])
                let section = NSCollectionLayoutSection(group: bannerGroup)
                section.orthogonalScrollingBehavior = .paging
                return section
                
            } else if section == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize:  groupSize, subitems: [item])
                let section  = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                
                //Header and footer
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension:  .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: categoryHeaderId, alignment: .topLeading)]
                return section
            } else if section == 2 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.trailing = 32
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(125))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets.leading = 16
                return section
            } else {
                let itemSize = NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let groupSize = NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 25, leading: 16, bottom: 0, trailing: 0)
                return section
            }
        }
    }
    
    private let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = "Food App"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: FoodViewController.categoryHeaderId, withReuseIdentifier: headerId)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 8
        case 2:
            return 5
        default:
            return 11
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        // header.backgroundColor = .lightGray
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section:::\(indexPath.section) item:\(indexPath.item)")
        let hostingController = UIHostingController(rootView: SecondContentView())
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

class Header: UICollectionReusableView {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Categories"
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}

//********SWIFTTUI****************//
struct ContentView: View {
    @State var isPresented = false
    var body: some View {
        HStack {
            Button("Food Deliver") {
                isPresented = true
            }.foregroundColor(.green)
            .sheet(isPresented: $isPresented) {
                Container1()
                    .edgesIgnoringSafeArea(.all)
            }
            Button("Instagram Layout") {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                Container1()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
}

struct Container: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FoodViewController {
        let vc =  FoodViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: FoodViewController, context: Context) {
    }
    
    typealias UIViewControllerType = FoodViewController
    var controller: [UIViewController] = []
}
