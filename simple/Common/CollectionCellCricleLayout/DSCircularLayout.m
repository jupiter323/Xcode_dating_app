//
//  DSCircularLayout.m
//  DSCircularCollection-ViewExample
//
//  Created by Srinivasan Dodda on 04/07/16.
//  Copyright © 2016 Srinivasan Dodda. All rights reserved.
//

#import "DSCircularLayout.h"

@implementation DSCircularLayout{
    long cellCount;
    CGFloat maxNoOfCellsInCircle;

}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)initWithCentre:(CGPoint)centre radius:(CGFloat)radius itemSize:(CGSize)itemSize andAngularSpacing:(CGFloat)angularSpacing{
    _centre = centre;
    _radius = radius;
    _itemSize = itemSize;
    _angularSpacing = angularSpacing;
}

-(void)setStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{

}

-(void)prepareLayout{
    [super prepareLayout];
    cellCount = [self.collectionView numberOfItemsInSection:0];
}

-(CGSize)collectionViewContentSize{

    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height) ;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    CGFloat originX = self.collectionView.frame.origin.x + self.collectionView.frame.size.width /2;
    CGFloat originY = self.collectionView.frame.origin.y + self.collectionView.frame.size.height /2;
    CGFloat smallR = 81;
    CGFloat R = self.radius;
    CGFloat r = self.itemSize.width / 2;
    CGFloat rSR = (R-smallR-r*2)/2;
    int i = -indexPath.item;
    CGFloat x = originX+ cosf(i*M_PI/5) * (R-r-rSR);
    CGFloat y = originY+ sinf(i*M_PI/5) * (R-r-rSR);
    
    attributes.size = CGSizeMake(4*r, 4*r);
    attributes.center = CGPointMake(x,y);
    
    return attributes;
}

-(NSArray <__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    NSLog(@"here");
    
    return attributes;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
