//
//  UICollectionViewGridLayout.swift
//
//  Created by Yevhen Biiak on 05.11.2023.
//

import UIKit

public class UICollectionViewGridLayout: UICollectionViewLayout {
    
    public enum GridLayoutColumn {
        case count(CGFloat)
        case width(CGFloat)
        case aspectRatio(toRow: CGFloat)
    }
    
    public enum GridLayoutRow {
        case count(CGFloat)
        case height(CGFloat)
        case aspectRatio(toColumn: CGFloat)
    }
    
    public struct GridLayoutSpacing: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {

        fileprivate var horizontal: CGFloat
        fileprivate var vertical: CGFloat
        
        fileprivate init(horizontal: CGFloat, vertical: CGFloat) {
            self.horizontal = horizontal
            self.vertical = vertical
        }
        
        public init(floatLiteral value: Double) {
            self.horizontal = CGFloat(value)
            self.vertical = CGFloat(value)
        }
        
        public init(integerLiteral value: Int) {
            self.horizontal = CGFloat(value)
            self.vertical = CGFloat(value)
        }
        
        public static func custom(horizontal: CGFloat, vertical: CGFloat) -> GridLayoutSpacing {
            GridLayoutSpacing(horizontal: horizontal, vertical: vertical)
        }
    }
    
    /// by default row = .count(2)
    public var row: GridLayoutRow = .count(2)
    /// by default column = .count(2)
    public var column: GridLayoutColumn = .count(2)
    /// by default spacing = 0
    public var spacing: GridLayoutSpacing = 0
    /// by default scrollDirection = .vertical
    public var scrollDirection: UICollectionView.ScrollDirection = .vertical
    /// by default contentInsets = .zero
    public var contentInsets: NSDirectionalEdgeInsets = .zero
    
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat = 0
    private var itemsAttributes = [UICollectionViewLayoutAttributes]()
    
    // MARK: Overriden methods
    
    public override func prepare() {
        super.prepare()
        
        // Calculate layout attributes for all items in the collection view
        guard let collectionView = collectionView else { return }
        
        itemsAttributes.removeAll()
        contentWidth  = .zero
        contentHeight = .zero
        
        var origin   = CGPoint(x: contentInsets.leading, y: contentInsets.top)
        var itemSize = CGSize.zero
        var numberOfVisibleRows    = CGFloat.zero
        var numberOfVisibleColumns = CGFloat.zero
        
        let availableWidth  = collectionView.bounds.width - contentInsets.leading - contentInsets.trailing
        let availableHeight = collectionView.bounds.height - contentInsets.top - contentInsets.bottom
        
        contentWidth  = availableWidth
        contentHeight = availableHeight
        
        if case .count(let columnCount) = column {
            numberOfVisibleColumns = scrollDirection == .horizontal ? columnCount.rounded(.up) : columnCount.rounded(.down)
            itemSize.width = (availableWidth - (numberOfVisibleColumns - 1) * spacing.horizontal) / columnCount
        } else if case .width(let widthValue) = column {
            itemSize.width = widthValue
            recalculateNumberOfVisibleColumns()
        }
        
        if case .count(let rowCount) = row {
            numberOfVisibleRows = scrollDirection == .vertical ? rowCount.rounded(.up) : rowCount.rounded(.down)
            itemSize.height = (availableHeight - (numberOfVisibleRows - 1) * spacing.vertical) / rowCount
        } else if case .height(let heightValue) = row {
            itemSize.height = heightValue
            recalculateNumberOfVisibleRows()
        }
        
        if case .aspectRatio(let aspectRatio) = column {
            itemSize.width = itemSize.height * aspectRatio
            recalculateNumberOfVisibleColumns()
        }
        if case .aspectRatio(let aspectRatio) = row {
            itemSize.height = itemSize.width / aspectRatio
            recalculateNumberOfVisibleRows()
        }
        
        func recalculateNumberOfVisibleColumns() {
            numberOfVisibleColumns = (availableWidth  / itemSize.width).rounded(.up)
            while availableWidth < numberOfVisibleColumns * itemSize.width + (numberOfVisibleColumns - 1) * spacing.horizontal {
                numberOfVisibleColumns -= 1
            }
        }
        
        func recalculateNumberOfVisibleRows() {
            numberOfVisibleRows = (availableHeight / itemSize.height).rounded(.up)
            while availableHeight < numberOfVisibleRows * itemSize.height + (numberOfVisibleRows - 1) * spacing.vertical {
                numberOfVisibleRows -= 1
            }
        }

        // Iteration
        
        let numberOfSections = collectionView.numberOfSections
        
        for section in 0..<numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            
            var index: CGFloat = 0
            for item in 0..<numberOfItems {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: item, section: section))
                if scrollDirection == .vertical {
                    if index >= numberOfVisibleColumns {
                        index = 0
                        origin.y += itemSize.height + spacing.vertical
                    }
                    origin.x = contentInsets.leading + CGFloat(index) * (itemSize.width + spacing.horizontal)
                    
                    let itemFrame = CGRect(origin: origin, size: itemSize)
                    attributes.frame = itemFrame
                    itemsAttributes.append(attributes)
                    contentHeight = itemFrame.maxY + contentInsets.bottom
                } else {
                    if index >= numberOfVisibleRows {
                        index = 0
                        origin.x += itemSize.width + spacing.horizontal
                    }
                    origin.y = contentInsets.top + CGFloat(index) * (itemSize.height + spacing.vertical)
                    
                    let itemFrame = CGRect(origin: origin, size: itemSize)
                    attributes.frame = itemFrame
                    itemsAttributes.append(attributes)
                    contentWidth = itemFrame.maxX + contentInsets.trailing
                }
                index += 1
            }
        }
    }
    
    /// - Tag: CollectionViewContentSize
    public override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    /// - Tag: LayoutAttributesForItem
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        itemsAttributes.first {
            $0.indexPath == indexPath
        }
    }
    
    /// - Tag: LayoutAttributesForElements
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        itemsAttributes.filter {
            $0.frame.intersects(rect)
        }
    }
    
    /// - Tag: ShouldInvalidateLayout
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if scrollDirection == .vertical, let oldWidth = collectionView?.bounds.width {
            return oldWidth != newBounds.width
        } else if scrollDirection == .horizontal, let oldHeight = collectionView?.bounds.height {
            return oldHeight != newBounds.height
        }
        
        return false
    }
    
    /// - Tag: InvalidateLayout
    public override func invalidateLayout() {
        super.invalidateLayout()
        
        itemsAttributes = []
        contentWidth = 0
        contentHeight = 0
    }
}
