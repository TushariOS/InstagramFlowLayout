//
//  SecondContentView.swift
//  CompositionalLayoutWithSwiftUI
//
//  Created by Tushar Jaunjalkar on 12/04/23.
//

import SwiftUI

class SecondViewController: UICollectionViewController {
    init() {
        super.init(collectionViewLayout: SecondViewController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout {(section, env) -> NSCollectionLayoutSection in
            let itemSize = NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(1/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            //Group1....
            let item1Group1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
            item1Group1.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            //Group1 Dividesd into subgroup and item
            let nestedGrop1Item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)))
            nestedGrop1Item1.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            let nestedGroup1 = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)), subitems: [nestedGrop1Item1])
            
            let sizeGroup1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
            let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: sizeGroup1, subitems: [item1Group1, nestedGroup1])
            
            //Group2....
            let item1Group2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
            item1Group2.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
            let sizeGroup2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
            let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: sizeGroup2, subitems: [item1Group2])
            
            //Container Group....
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600)), subitems: [item, group1, group2] )
            let section = NSCollectionLayoutSection(group: containerGroup)
            return section
        }
    }
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = "Instagram Layout"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 70
    }
}

struct SecondContentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SecondContentView_Previews: PreviewProvider {
    typealias UIViewControllerType = UIViewController
    static var previews: some View {
        Container1().edgesIgnoringSafeArea(.all)
    }
}
struct Container1: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: SecondViewController())
        // return SecondViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1),
                       green: .random(in: 0.4...1),
                       blue: .random(in: 0.3...1),
                       alpha: 1)
    }
}
