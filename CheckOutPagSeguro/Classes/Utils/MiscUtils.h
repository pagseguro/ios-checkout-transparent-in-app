//
//  MiscUtils.h
//  InAppPurchase
//
//  Created by TQI on 13/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MiscUtils : NSObject
+(NSString*) formatReal: (NSString*) valor eMostrarSimbolo:(BOOL) mostrarSimbolo ;

+ (UIImage*) fitImage:(UIImage*)image inBox:(CGSize)size withBackground:(UIColor*)color;
+(NSString*) formatStringDecimal: (NSString*) stringSemFormato;
+(NSString *)formatValueDecimal:(NSString *)valor;

@end
