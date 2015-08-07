//
//  AZXCollectionViewPubuLayout.h
//  Proj_PuBuLiu
//
//  Created by Azen.Xu on 15/8/7.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AZXCollectionViewPubuLayout;

@protocol AZXCollectionViewPubuLayoutDelegate <NSObject>

@required

- (CGFloat)heightForIndexPath :(NSIndexPath *)indexPath;

@optional

- (CGFloat)colMarginForLayout :(AZXCollectionViewPubuLayout *)layout;
- (NSUInteger)colNumberForLayout :(AZXCollectionViewPubuLayout *)layout;
- (CGFloat)rowMarginForLayout :(AZXCollectionViewPubuLayout *)layout;
- (UIEdgeInsets)edgeInsetsForLayout :(AZXCollectionViewPubuLayout *)layout;

@end


@interface AZXCollectionViewPubuLayout : UICollectionViewLayout

/** 代理*/
@property(weak,nonatomic) id<AZXCollectionViewPubuLayoutDelegate> delegate;

@end
