//
//  HomecardCollectionViewCell.m
//  CollectionHome
//
//  Created by TQI on 08/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "HomecardCollectionViewCell.h"



@implementation HomecardCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setLayoutViews:self.viewItem valid:NO];
    [self setLayoutViews:self.imageItem valid:YES];

    
}

-(void)setLayoutViews:(UIView*)view valid:(BOOL)valid{
    
    view.layer.masksToBounds = valid;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 3;
    view.layer.shadowOpacity = 0.7;
    view.layer.cornerRadius = 5;

    
}

@end
