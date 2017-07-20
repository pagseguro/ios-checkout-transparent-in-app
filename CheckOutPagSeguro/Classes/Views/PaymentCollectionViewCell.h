//
//  PaymentCollectionViewCell.h
//  InAppPurchase
//
//  Created by TQI on 13/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGuidedView.h"
#import "CheckoutTransparent.h"
#import "AuthorizationLib.h"

@interface PaymentCollectionViewCell : UICollectionViewCell<UIGuidedViewDataSource, UIGuidedViewDelegate>


@property CheckoutTransparent *checkoutTransparent;

@property  (strong, nonatomic) UINavigationController *viewController;

@property (strong, nonatomic) IBOutlet UIGuidedView *guidedView;

-(void)setup;
@property (weak, nonatomic) IBOutlet UIView *itemSelected;
@property (weak, nonatomic) IBOutlet UIView *descriptionValue;
@property (weak, nonatomic) IBOutlet UIView *dadosCard;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirmation;

- (IBAction)btnConfirmation:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lblNumbercard;
@property (weak, nonatomic) IBOutlet UILabel *lblExpireDate;
@property (weak, nonatomic) IBOutlet UILabel *lblNameUser;
@property (strong, nonatomic)  NSString *CVV;
@property (strong, nonatomic)  NSString *numberCard;



@property (weak, nonatomic) IBOutlet UILabel *lblValueItem;
@property (weak, nonatomic) IBOutlet UILabel *lblValueAll;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;


@property (weak, nonatomic) IBOutlet UIImageView *imageItem;
@property (weak, nonatomic) IBOutlet UILabel *nameItem;
@property (weak, nonatomic) IBOutlet UILabel *descriptionItem;

@end
