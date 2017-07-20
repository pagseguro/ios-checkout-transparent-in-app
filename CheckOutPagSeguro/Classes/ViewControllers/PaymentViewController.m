//
//  PaymentViewController.m
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//



#import "PaymentViewController.h"
#import "PaymentCollectionViewCell.h"
#import "MiscUtils.h"


@interface PaymentViewController ()< UICollectionViewDelegate, UICollectionViewDataSource>{
    
    PaymentCollectionViewCell *cell;
}
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *paymentCollectionView;


@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
     [cell setup];
}

- (void)setup{
    
    
    
    [self.paymentCollectionView registerNib:[UINib nibWithNibName:@"PaymentCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PaymentCollectionViewCell_XIB"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setLayoutViews:(UIView*)view{
    
    view.layer.masksToBounds = NO;
    
    view.layer.cornerRadius = 10;
    
}

- (IBAction)btnBack:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    cell = (PaymentCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PaymentCollectionViewCell_XIB" forIndexPath:indexPath];
    
    NSString * card =self.numberCard;
    
    if (self.numberCard.length >=4) {
        
        card = [card substringWithRange: NSMakeRange(card.length-4, 4)];
    }
    
    cell.lblNumbercard.text = [NSString stringWithFormat:@"**** **** **** %@",card];
    cell.lblExpireDate.text = self.expireDate;
    cell.lblNameUser.text = self.nameUser;
    cell.lblValueItem.text =[MiscUtils formatReal: self.itemPayment.valueItem eMostrarSimbolo:YES];
    cell.CVV = self.CVV;
    cell.numberCard = self.numberCard;

    cell.lblValueAll.text = self.itemPayment.valueAll;
    cell.lblAmount.text = [NSString stringWithFormat:@"%@ un", self.itemPayment.amountAll];
    
    
    CGSize newSize =   CGSizeMake (110  , 110);
    cell.imageItem.image = [MiscUtils fitImage:[UIImage imageNamed:self.itemPayment.imageItem] inBox:newSize withBackground:[UIColor whiteColor]];
    
    cell.nameItem.text = self.itemPayment.nameItem;
    cell.descriptionItem.text = self.itemPayment.descriptionItem;
    cell.viewController= self.navigationController ;
   
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width;
    
    switch (indexPath.row) {
        case 0:
        {
            return CGSizeMake(width, 620);
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
