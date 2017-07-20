//
//  DetailItemViewController.m
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "DetailItemViewController.h"
#import "DetailItemCollectionViewCell.h"
#import "JTSlideShadowAnimation.h"

@interface DetailItemViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleHome;
@property (strong, nonatomic) JTSlideShadowAnimation *shadowAnimation;

@end

@implementation DetailItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.shadowAnimation = [JTSlideShadowAnimation new];
    self.shadowAnimation.animatedView = self.titleHome;
    self.shadowAnimation.shadowBackgroundColor = [UIColor colorWithWhite:0. alpha:0.3];
    self.shadowAnimation.shadowForegroundColor = [UIColor blackColor];
    self.shadowAnimation.shadowWidth = 80.;
    self.shadowAnimation.duration = 3.;
    
    [self.shadowAnimation start];
    

    
    [self setup];
    
    
    
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    
}






- (void)setup{
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"DetailItemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DetailItemCollectionViewCell_XIB"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            DetailItemCollectionViewCell *cell = (DetailItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DetailItemCollectionViewCell_XIB" forIndexPath:indexPath];
            
            cell.viewController = self.navigationController ;
            [cell setup:self.itemSelected];
            
            return cell;
        }
            break;
            
            
        default:
        {
            UICollectionViewCell *cellView = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
            return cellView;
        }
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
        default:
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width;
    
    switch (indexPath.row) {
        case 0:
        {
            return CGSizeMake(width, 700);
        }
            break;
            
        default:
            return CGSizeMake(width, 300);
            break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}


- (IBAction)back:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
@end
