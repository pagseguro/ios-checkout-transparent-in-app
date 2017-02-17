//
//  Transparent
//
//  Created by TQI on 03/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "AMPActivityIndicator.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat AMPActivityIndicatorDefaultSpeed = 0.8f;
static NSString * const AMPActivityIndicatorAnimationKey = @"AMPActivityIndicatorAnimationKey";

@interface AMPActivityIndicator ()

@property (nonatomic) CGFloat hudSize;
@property (nonatomic) NSInteger numberOfBars;

@property (nonatomic) CALayer *marker;
@property (nonatomic) CAReplicatorLayer *spinnerReplicator;
@property (nonatomic) CABasicAnimation *fadeAnimation;

@end

@implementation AMPActivityIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self setBackgroundColor:[UIColor clearColor]];
    
    _barColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _aperture = 31.8f;
    _numberOfBars = 10.0f;
    _barWidth = 70.0f;
    _barHeight = 14.0f;
    
    [self createLayers];
    [self updateLayers];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.hudSize = CGRectGetWidth(self.bounds);
    [self updateLayers];
}

- (void)updateLayers
{
    // Update marker
    [self.marker setBounds:CGRectMake(0.0f, 0.0f, _barWidth, _barHeight)]; // size of the rectangle marker
//    [self.marker setCornerRadius:_barWidth * 0.5];
    [self.marker setBackgroundColor:[_barColor CGColor]];
    [self.marker setPosition:CGPointMake(self.hudSize * 0.5f, self.hudSize * 0.5f + _aperture)];
    
    // Update replicaitons
    [self.spinnerReplicator setBounds:CGRectMake(0.0f, 0.0f, self.hudSize, self.hudSize)];
//    [self.spinnerReplicator setCornerRadius:10.0f];
    [self.spinnerReplicator setPosition:CGPointMake(CGRectGetMidX(self.bounds),
                                                    CGRectGetMidY(self.bounds))];
    
    CGFloat angle = (2.0f * M_PI) / (self.numberOfBars);
    CATransform3D instanceRotation = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
    [self.spinnerReplicator setInstanceCount:self.numberOfBars];
    [self.spinnerReplicator setInstanceTransform:instanceRotation];
}

- (void)createLayers {
    [self.spinnerReplicator addSublayer:self.marker];
    [self.layer addSublayer:self.spinnerReplicator];
    
    [self.marker setOpacity:0.0f]; // will be visible thanks to the animation
}

#pragma mark Public methods

- (void)startAnimating
{
    [self.fadeAnimation setDuration:AMPActivityIndicatorDefaultSpeed];
    CGFloat markerAnimationDuration = AMPActivityIndicatorDefaultSpeed / self.numberOfBars;
    [self.spinnerReplicator setInstanceDelay:markerAnimationDuration];
    [self.marker addAnimation:self.fadeAnimation forKey:AMPActivityIndicatorAnimationKey];
}

- (void)stopAnimating
{
    [self.marker removeAnimationForKey:AMPActivityIndicatorAnimationKey];
}

- (BOOL)isAnimating
{
    return [self.marker animationForKey:AMPActivityIndicatorAnimationKey] != nil;
}

#pragma mark - Getters
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

- (CALayer *)marker {
    if (!_marker) {
        _marker = [CALayer layer];
    }
    UIBezierPath* piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint: CGPointMake(26.89, -0.22)];
    [piePath addLineToPoint: CGPointMake(25.7, 3.6)];
    [piePath addLineToPoint: CGPointMake(25.94, 3.68)];
    [piePath addCurveToPoint: CGPointMake(44.3, 3.51) controlPoint1: CGPointMake(31.93, 5.51) controlPoint2: CGPointMake(38.34, 5.45)];
    [piePath addLineToPoint: CGPointMake(42.83, -0.22)];
    [piePath addLineToPoint: CGPointMake(42.62, -0.15)];
    [piePath addCurveToPoint: CGPointMake(26.66, -0.29) controlPoint1: CGPointMake(37.41, 1.44) controlPoint2: CGPointMake(31.84, 1.39)];
    [piePath addLineToPoint: CGPointMake(26.89, -0.22)];
    [piePath closePath];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = _marker.bounds;
    shape.path = piePath.CGPath;
    
    //shape.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(0.0), 0.0, 0.0, 1.0);
    _marker.mask = shape;
    return _marker;
}

- (CAReplicatorLayer *)spinnerReplicator {
    if (!_spinnerReplicator) {
        _spinnerReplicator = [CAReplicatorLayer layer];
    }
    return _spinnerReplicator;
}

- (CABasicAnimation *)fadeAnimation {
    if (!_fadeAnimation) {
        _fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    }
    
    [_fadeAnimation setFromValue:[NSNumber numberWithFloat:1.0f]];
    [_fadeAnimation setToValue:[NSNumber numberWithFloat:0.0f]];
    [_fadeAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [_fadeAnimation setRepeatCount:HUGE_VALF];
    
    return _fadeAnimation;
}

#pragma mark - Setters

- (void)setBarColor:(UIColor *)barColor {
    _barColor = barColor;
    [self updateLayers];
}

- (void)setBarWidth:(CGFloat)barWidth {
    _barWidth = barWidth;
    [self updateLayers];
}

- (void)setBarHeight:(CGFloat)barHeight {
    _barHeight = barHeight;
    [self updateLayers];
}

- (void)setAperture:(CGFloat)aperture {
    _aperture = aperture;
    [self updateLayers];
}

@end
