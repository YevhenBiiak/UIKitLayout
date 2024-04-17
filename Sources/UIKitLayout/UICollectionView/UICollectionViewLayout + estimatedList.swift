//
//  UICollectionViewLayout + estimatedList.swift
//
//  Created by Yevhen Biiak on 05.02.2024.
//

import UIKit

extension UICollectionViewLayout {
    
    public static func horizontalEstimatedList(spacing: CGFloat = 16, expectedWidth: CGFloat = 100) -> UICollectionViewLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .estimated(expectedWidth),
            heightDimension: .fractionalHeight(1.0))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .estimated(expectedWidth),
            heightDimension: .fractionalHeight(1.0)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    public static func verticalEstimatedList(spacing: CGFloat = 16, expectedHeight: CGFloat = 100) -> UICollectionViewLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(expectedHeight)
        ))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(expectedHeight)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
}
