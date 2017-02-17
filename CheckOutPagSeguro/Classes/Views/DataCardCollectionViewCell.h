//
//  DataCardCollectionViewCell.h
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGuidedView.h"
#import "ItemPayment.h"

@interface DataCardCollectionViewCell :  UICollectionViewCell<UITextFieldDelegate, UIGuidedViewDataSource, UIGuidedViewDelegate>{

}
@property   ItemPayment * itemPayment;

@property  NSDictionary *itemSelected;
@property  NSString *stringFormattedAmount;

@property  (strong, nonatomic) UINavigationController *viewController;

@property (strong, nonatomic) IBOutlet UIGuidedView *guidedView;

@property (weak, nonatomic) IBOutlet UIView *viewData;

- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)btnNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;


@property (weak, nonatomic) IBOutlet UIImageView *imageViewCard;


@property (weak, nonatomic) IBOutlet UILabel *lblNumbercard;
@property (weak, nonatomic) IBOutlet UILabel *lblExpireDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCVV;
@property (weak, nonatomic) IBOutlet UILabel *lblNameUser;


@property (weak, nonatomic) IBOutlet UILabel *lblExpireDateMessage;

@property (weak, nonatomic) IBOutlet UITextField *txtNumbercard;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireDate;
@property (weak, nonatomic) IBOutlet UITextField *txtCVV;
@property (weak, nonatomic) IBOutlet UITextField *txtNameUser;


@property (weak, nonatomic) IBOutlet UILabel *lblData;

+(int)getCounterView;
+(void)setCounterView:(int)counter;
- (void)segmentedControlWasTouched:(int)selectedSegmentIndex ;


@end
