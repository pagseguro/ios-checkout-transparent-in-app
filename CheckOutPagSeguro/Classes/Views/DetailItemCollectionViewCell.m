//
//  DetailItemCollectionViewCell.m
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "DetailItemCollectionViewCell.h"
#import "DataCardViewController.h"
#import "MiscUtils.h"
#import "DataCardViewController.h"
#import "ItemPayment.h"

@implementation DetailItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setLayoutViews:self.viewName valid:NO];
    [self setLayoutViews:self.viewTotal valid:NO];
    [self setLayoutViews:self.viewAmount valid:NO];
    [self setLayoutViews:self.purchase valid:NO];
    
    
}
-(void)setLayoutViews:(UIView*)view valid:(BOOL)valid{
    
    view.layer.masksToBounds = valid;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 3;
    view.layer.shadowOpacity = 0.7;
    view.layer.cornerRadius = 5;
    
    
}
- (IBAction)sliderValueChanged:(id)sender {
    
    self.labelSilder.text = [NSString stringWithFormat:@"%.0f un", self.slider.value];
    
    NSString * amount  =[NSString stringWithFormat:@"%.0f", self.slider.value];
    
    NSString * value  =[NSString stringWithFormat:@"%.0f", [amount doubleValue] * [self.itemSelected[@"value"] doubleValue]];
    self.valuePayment.text =[MiscUtils formatReal: value eMostrarSimbolo:YES];
    
}


-(void)setup:(NSDictionary*)item{
    self.itemSelected = item;
    
    CGSize newSize =   CGSizeMake (400  , 400);
    self.imageItem.image = [MiscUtils fitImage:[UIImage imageNamed:item[@"image"]] inBox:newSize withBackground:[UIColor whiteColor]];
    self.valueItem.text =[MiscUtils formatReal: item[@"value"] eMostrarSimbolo:YES];
    self.descriptionItem.text =item[@"description"];
    self.nameItem.text =item[@"name"];
    self.valuePayment.text =[MiscUtils formatReal: item[@"value"] eMostrarSimbolo:YES];
    
}

- (IBAction)btnPurchase:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ItemPayment * item  = [[ItemPayment alloc]init];
    
    item.descriptionItem = self.itemSelected[@"description"];
    item.nameItem =  self.itemSelected[@"name"];
    item.valueItem =  self.itemSelected[@"value"];
    item.imageItem =  self.itemSelected[@"image"];
    item.amountAll = [NSString stringWithFormat:@"%.0f", self.slider.value];
    item.valueAll =  self.valuePayment.text;


    DataCardViewController *paymentViewController = [board instantiateViewControllerWithIdentifier:@"DataCardViewController"];
    paymentViewController.itemPayment = item;
    
    [DataCardViewController sharedInstance:paymentViewController];

    
    [self.viewController pushViewController:paymentViewController animated:YES];
    
}

@end
