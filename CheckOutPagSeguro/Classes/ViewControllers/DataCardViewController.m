//
//  DataCardViewController.m
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "DataCardViewController.h"
#import "DataCardCollectionViewCell.h"
#import "PaymentViewController.h"
#import "JTSlideShadowAnimation.h"

@interface DataCardViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>{
    
    DataCardCollectionViewCell *cell;
}
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
- (IBAction)back:(id)sender;


@end

@implementation DataCardViewController

+ (instancetype)sharedInstance:(UIViewController *)controller
{
    static DataCardViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = (DataCardViewController *)controller;
    });
    
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self inicializaGesto];
    
    [self setup];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    if ([DataCardCollectionViewCell getCounterView]==4) {
        [DataCardCollectionViewCell setCounterView:[DataCardCollectionViewCell getCounterView]-1];
        [cell segmentedControlWasTouched:[DataCardCollectionViewCell getCounterView]];
    }
}
- (IBAction)back:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(void) inicializaGesto {
    UIGestureRecognizer *gesto  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickForaTeclado)];
    gesto.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gesto];
}

-(void)setScrollTextField{
    
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height<=568) {
          self.homeCollectionView.contentOffset = CGPointMake(0, 100);
    }else{
        self.homeCollectionView.contentOffset = CGPointMake(0, 140);

        
    }
    
}

-(void)clickForaTeclado {
    [self.view  endEditing:YES];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height<=568) {
        self.homeCollectionView.contentOffset = CGPointMake(0, 5);
    }
    
}

- (void)setup{
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"DataCardCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DataCardCollectionViewCell_XIB"];
    
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
            cell = (DataCardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DataCardCollectionViewCell_XIB" forIndexPath:indexPath];
            cell.viewController = self.navigationController ;
            
            cell.itemPayment   = self.itemPayment  ;
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
            return CGSizeMake(width, 454);
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



@end
