//
//  PSGradientView.h
//  PSGradientView
//
//  Created by Rodrigo Cai on 2/2/16.
//  Copyright © 2016 UOL. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface PSGradientView : UIView
@property (nonatomic, strong, readonly) CAGradientLayer *layer;
@property IBInspectable UIColor *startColor;
@property IBInspectable UIColor *endColor;
@end

@interface PSGradientHeaderView : PSGradientView
@end


