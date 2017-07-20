//
//  PSGradientView.m
//  PSGradientView
//
//  Created by Rodrigo Cai on 2/2/16.
//  Copyright © 2016 UOL. All rights reserved.
//

#import "PSGradientView.h"

#define UIColorFromHex(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]


@interface PSGradientView ()
@end

@implementation PSGradientView
@synthesize startColor = _startColor;
@synthesize endColor = _endColor;

@dynamic layer;
+ (Class)layerClass {
    
    return [CAGradientLayer class];
}

//- (void)awakeFromNib{
//    [super awakeFromNib];
//    
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.layer.colors = [NSArray arrayWithObjects:
//                         (id)UIColorFromHEX(0x48ac5b).CGColor,
//                         (id)UIColorFromHEX(0x78d337).CGColor,  nil];
//    
//    self.layer.startPoint =  CGPointMake(0.5,0.0);
//    self.layer.endPoint =    CGPointMake(0.5,1.0);
//    self.layer.locations = [NSArray arrayWithObjects:
//                            [NSNumber numberWithFloat:0.0],
//                            [NSNumber numberWithFloat:0.95],nil];
//}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self updateGradientColors];
    
}

- (UIColor *)startColor{
    return _startColor;
}

- (void)setStartColor:(UIColor *)startColor{
    _startColor = startColor;
    [self updateGradientColors];
}

- (UIColor *)endColor{
    return _endColor;
}

- (void)setEndColor:(UIColor *)endColor{
    _endColor = endColor;
    [self updateGradientColors];
}

- (void)updateGradientColors{
    UIColor *aColor = self.endColor ? self.endColor : UIColorFromHex(0x4E84C0);
    UIColor *sColor = self.startColor ? self.startColor :UIColorFromHex(0xE0FFFF);
    UIColor *bColor = self.startColor ? self.startColor :UIColorFromHex(0xE0FFFF);
    UIColor *eColor = self.endColor ? self.endColor : UIColorFromHex(0x4E84C0);
    
    self.layer.startPoint   =   CGPointMake(0.5,0.0);
    self.layer.endPoint     =   CGPointMake(0.5,1.0);
    self.layer.locations    =   @[@0.0,@0.50,@0.90,@0.99];
    

    
    self.layer.colors = [NSArray arrayWithObjects:
                        (id)aColor.CGColor,
                        (id)sColor.CGColor,
                         (id)bColor.CGColor,
                         (id)eColor.CGColor, nil];
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 1.0f};
    CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.5f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    
    CGPoint gradCenter= CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    
    CGContextDrawRadialGradient (ctx, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
    
    
    CGGradientRelease(gradient);
}
@end

