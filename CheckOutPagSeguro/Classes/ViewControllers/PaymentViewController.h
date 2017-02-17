//
//  PaymentViewController.h
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemPayment.h"
@interface PaymentViewController : UIViewController

@property (strong, nonatomic)  NSString *nameUser;
@property (strong, nonatomic)  NSString *numberCard;
@property (strong, nonatomic)  NSString *expireDate;
@property (strong, nonatomic)  NSString *CVV;
@property   ItemPayment * itemPayment;

@end
