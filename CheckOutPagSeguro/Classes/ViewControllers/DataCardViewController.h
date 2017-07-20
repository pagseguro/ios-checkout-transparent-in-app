//
//  DataCardViewController.h
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemPayment.h"

@interface DataCardViewController : UIViewController

-(void)setScrollTextField;
+ (instancetype)sharedInstance:(UIViewController *)controller;

@property   ItemPayment * itemPayment;

@end
