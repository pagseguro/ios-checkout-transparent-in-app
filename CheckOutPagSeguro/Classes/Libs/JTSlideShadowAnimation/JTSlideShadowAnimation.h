//
//
//  Transparent
//
//  Created by TQI on 03/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface JTSlideShadowAnimation : NSObject

@property (weak, nonatomic) UIView *animatedView;

@property (strong, nonatomic) UIColor *shadowBackgroundColor;
@property (strong, nonatomic) UIColor *shadowForegroundColor;
@property (assign, nonatomic) CGFloat shadowWidth;
@property (assign, nonatomic) CGFloat repeatCount;
@property (assign, nonatomic) NSTimeInterval duration;

- (void)start;
- (void)stop;

@end
