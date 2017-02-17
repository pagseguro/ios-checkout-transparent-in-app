//
//  DetailItemCollectionViewCell.h
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailItemCollectionViewCell : UICollectionViewCell{
    NSString * amountSelect;

}

-(void)setup:(NSDictionary*)item;


@property  NSDictionary *itemSelected;

@property (weak, nonatomic) IBOutlet UIButton *purchase;
@property  (strong, nonatomic) UINavigationController *viewController;

@property (nonatomic, strong) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UIView *viewTotal;
@property (weak, nonatomic) IBOutlet UIView *viewAmount;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *labelSilder;
@property (weak, nonatomic) IBOutlet UILabel *valuePayment;
- (IBAction)sliderValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageItem;
@property (weak, nonatomic) IBOutlet UILabel *nameItem;
@property (weak, nonatomic) IBOutlet UILabel *descriptionItem;
@property (weak, nonatomic) IBOutlet UILabel *valueItem;

@end
