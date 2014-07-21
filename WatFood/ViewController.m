//
//  ViewController.m
//  WatFood
//
//  Created by Ken Huang on 2014-07-17.
//  Copyright (c) 2014 Ken Huang. All rights reserved.
//

#import "ViewController.h"
#import "FoodManager.h"
#import "UIImageView+WebCache.h"
#import "Place.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *foodArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.itemSize = CGSizeMake(80.0f, 80.0f);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor blueColor];
    [[FoodManager sharedManager] getFoodInfoForLocatoin:@"43.648753,-79.374245" radius:@"100" success:^(id responseObject) {
        _foodArray = [[FoodManager sharedManager] getFoodInfoFromResponse:responseObject];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation) {
        
    }];
    NSString *string = @"CnRnAAAAKd6UTGYIGkFlnII6Xl9_Z1g41qAa8MxGJYpyEuorW5wYFNBS3KqqA7-yp_UqyxnUl1JmZlFu3tebJjsmMDY2R5Cx4mrLTQZxE3eEdqOAXEjJwdcfiJKkBNti26XBJHRLnxIE9os8H1rCZwcXxUK21hIQmn5jVX8W7oRZaVGE1wGuChoU2O6SHWHL_q5sj-WyWT6bhS3EWSA";
    
    [[FoodManager sharedManager] getFoodPhotoWithReference:string success:^(id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation) {
        
    }];
    [[FoodManager sharedManager] downloadSomeshit];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _foodArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Place *place = _foodArray[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    [cell.contentView addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=80&maxheight=80&photoreference=%@&key=AIzaSyBcEHSHXCIdwqkcMeCLabFaPZc4W3BjUgQ",place.photoReference]]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80.0f, 80.0f);
}
@end
