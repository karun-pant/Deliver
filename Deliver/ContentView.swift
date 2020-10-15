//
//  ContentView.swift
//  Deliver
//
//  Created by Karun Pant on 27/09/20.
//

import SwiftUI

class HomeViewController: UICollectionViewController {
    
    enum Section: Int, CaseIterable {
        case hero, categories, offers, products
    }
    enum SectionHeader: String {
        case category = "Categories"
        case offer = "Offers"
        case product = "Products"
        case noHeader = "none"
        static func header(_ section: Section) -> SectionHeader {
            switch section {
            case .categories:
                return .category
            case .offers:
                return .offer
            case .hero:
                return .noHeader
            case .products:
                return .product
            }
        }
        var title: String {
            switch self {
            case .category:
                return "Categories"
            case .offer:
                return "Offers"
            case .product:
                return "Products"
            case .noHeader:
                return ""
            }
        }
    }
    private let cellID = "DeliversCell"
    
    init() {
        super.init(collectionViewLayout: HomeViewController.makeLayout())
    }
    
    static func makeLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: section) else { return nil }
            
            switch section {
            case .hero:
                let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 16
                item.contentInsets.trailing = 16
                item.contentInsets.top = 8
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.orthogonalScrollingBehavior = .paging
                return sectionLayout
            case .categories:
                let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
                let sectionLayout = NSCollectionLayoutSection(group: group)
                sectionLayout.contentInsets.leading = 16
                sectionLayout.contentInsets.bottom = -16
                
                // section header and footer settings
                let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: SectionHeader.category.rawValue, alignment: .topLeading)
                sectionLayout.boundarySupplementaryItems = [header]
                return sectionLayout
            case .offers:
                let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(125))
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, subitems: [item])
                let sectionLayout = NSCollectionLayoutSection(group: group)
                
                // section header and footer settings
                let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: SectionHeader.offer.rawValue, alignment: .topLeading)
                sectionLayout.boundarySupplementaryItems = [header]
                sectionLayout.orthogonalScrollingBehavior = .continuous
                sectionLayout.contentInsets.leading = 16
                return sectionLayout
            case .products:
                let groupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupLayoutSize, subitems: [item])
                let sectionLayout = NSCollectionLayoutSection(group: group)
                // section header and footer settings
                let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: SectionHeader.product.rawValue, alignment: .topLeading)
                sectionLayout.boundarySupplementaryItems = [header]
                sectionLayout.contentInsets.leading = 16
                sectionLayout.contentInsets.trailing = 16
                return sectionLayout
            }
             
            
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Delivers"
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: SectionHeader.category.rawValue, withReuseIdentifier: SectionHeader.header(.categories).rawValue)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: SectionHeader.offer.rawValue, withReuseIdentifier: SectionHeader.header(.offers).rawValue)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: SectionHeader.product.rawValue, withReuseIdentifier: SectionHeader.header(.products).rawValue)
    }
    
}

extension HomeViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        let numberOfItems: Int = {
            switch section {
            case .hero:
                return 3
            case .categories:
                return 8
            case .offers:
                return 4
            case .products:
                return 9
            }
        }()
        return numberOfItems
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.layer.cornerRadius = 4
        cell.backgroundColor = .systemPink
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = Section(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        let sectionHeaderType = SectionHeader.header(section)
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderType.rawValue, for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        header.setTitle(sectionHeaderType.title)
        return header
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewControllerRepresentable {
        typealias UIViewControllerType = UIViewController
        func makeUIViewController(context: Context) -> UIViewController {
            let homeVC = HomeViewController()
            return UINavigationController(rootViewController: homeVC)
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}
