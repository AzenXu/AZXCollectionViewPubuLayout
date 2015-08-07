//
//  ViewController.m
//  Proj_PuBuLiu
//
//  Created by Azen.Xu on 15/8/7.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "ViewController.h"
#import "AZXCollectionViewPubuLayout.h"

@interface ViewController ()<UICollectionViewDataSource,AZXCollectionViewPubuLayoutDelegate>

@end

@implementation ViewController

static NSString *ID = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollection];
}

- (void)setupCollection
{
    AZXCollectionViewPubuLayout *layout = [[AZXCollectionViewPubuLayout alloc] init];
    layout.delegate = self;
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    view.backgroundColor = [UIColor grayColor];
    [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    view.dataSource = self;
    
    [self.view addSubview:view];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath
{
    return arc4random_uniform(300);
}
- (CGFloat)colMarginForLayout:(AZXCollectionViewPubuLayout *)layout
{
    return 20;
}
- (CGFloat)rowMarginForLayout:(AZXCollectionViewPubuLayout *)layout
{
    return 10;
}
- (UIEdgeInsets)edgeInsetsForLayout:(AZXCollectionViewPubuLayout *)layout
{
    return UIEdgeInsetsMake(20, 10, 10, 10);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return cell;
}

@end
