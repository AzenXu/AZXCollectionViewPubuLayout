//
//  AZXCollectionViewPubuLayout.m
//  Proj_PuBuLiu
//
//  Created by Azen.Xu on 15/8/7.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "AZXCollectionViewPubuLayout.h"
@interface AZXCollectionViewPubuLayout()

/** 属性数组*/
@property(strong,nonatomic)  NSMutableArray *attArray;
/** colArray*/
@property(strong,nonatomic) NSMutableArray *colArray;
/** 列间距 */
@property(assign,nonatomic) CGFloat colMargin;
/** 行间距 */
@property(assign,nonatomic) CGFloat rowMargin;
/** 列数 */
@property(assign,nonatomic) NSUInteger colNumber;
/** 边距 */
@property(assign,nonatomic) UIEdgeInsets edgeInsets;

@end


@implementation AZXCollectionViewPubuLayout

//  储存最大 Y 值
static CGFloat maxHeightAtAll = 0;

# pragma mark --懒加载
- (CGFloat)colMargin
{
    _colMargin = [self.delegate respondsToSelector:@selector(colMarginForLayout:)] ? [self.delegate colMarginForLayout:self] : 10;
    return _colMargin;
}
- (CGFloat)rowMargin
{
    _rowMargin = [self.delegate respondsToSelector:@selector(rowMarginForLayout:)] ? [self.delegate rowMarginForLayout:self] : 10;
    return _rowMargin;
}
- (NSUInteger)colNumber
{
    _colNumber = [self.delegate respondsToSelector:@selector(colNumberForLayout:)] ? [self.delegate colNumberForLayout:self] : 3;
    return _colNumber;
}
- (UIEdgeInsets)edgeInsets
{
    _edgeInsets = [self.delegate respondsToSelector:@selector(edgeInsetsForLayout:)] ? [self.delegate edgeInsetsForLayout:self] : UIEdgeInsetsMake(10, 10, 10, 10);
    return _edgeInsets;

}


- (NSMutableArray *)attArray
{
    if (_attArray == nil) {
        _attArray = [NSMutableArray array];
    }
    return _attArray;
}

- (NSMutableArray *)colArray
{
    if (_colArray == 0) {
        _colArray = [NSMutableArray arrayWithArray:@[@(self.edgeInsets.top),@(self.edgeInsets.top),@(self.edgeInsets.top)]];
    }
    return _colArray;
}

//  布局
- (void)prepareLayout
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        [self.attArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
}

//  返回cell 属性数组
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.collectionView.bounds.size.width - (self.colNumber - 1) * self.colMargin - self.edgeInsets.left - self.edgeInsets.right) / self.colNumber;
    CGFloat height = [self.delegate heightForIndexPath :indexPath];
//    最短列 - 索引号 + 高度 -> 索引加数值，可以用数组来记录
//    找到最短列
    CGFloat minHeight = [self.colArray.firstObject floatValue];
    NSInteger minIndex = 0;
    for (int i = 1; i < self.colArray.count; i++) {
        CGFloat height = [self.colArray[i] floatValue];
        if (height < minHeight) {
            minHeight = height;
            minIndex = i;
        }
    }
    //  计算高度和宽度
    CGFloat x = self.edgeInsets.left + (minIndex * (width + self.colMargin));
    CGFloat y = minHeight == self.edgeInsets.top ? minHeight : minHeight + self.rowMargin;
    self.colArray[minIndex] = @(y + height);
    //  创建并返回 attribute
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = CGRectMake(x , y, width, height);
    
    [self.attArray addObject:attribute];
    
    //  最后一个cell属性创建完成，寻找最长列，作为最大 Y 值
    if (indexPath.row == [self.collectionView numberOfItemsInSection:0] - 1) {
        CGFloat maxHeight = [self.colArray.firstObject floatValue];
        //  寻找最大高度
        for (int i = 1; i < self.colArray.count; i++) {
            CGFloat height = [self.colArray[i] floatValue];
            if (height > maxHeight) {
                maxHeight = height;
            }
        }
        maxHeightAtAll = maxHeight + self.edgeInsets.bottom;
    }
    return attribute;
}

//  设置最大高度
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, maxHeightAtAll);
}

@end
