//
//  
//  ProjetoMenu
//
//  Created by TQI on 01/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "UIBezierPath+Center.h"

@implementation UIBezierPath (Center)

- (CGPoint)center{
    return CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end
