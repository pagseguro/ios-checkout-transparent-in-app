//
//  Transparent
//
//  Created by TQI on 03/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AMPActivityIndicator : UIView

@property (nonatomic) UIColor *barColor;
@property (nonatomic) CGFloat barWidth;
@property (nonatomic) CGFloat barHeight;
@property (nonatomic) CGFloat aperture;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
