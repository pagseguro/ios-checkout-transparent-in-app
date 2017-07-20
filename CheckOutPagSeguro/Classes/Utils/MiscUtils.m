//
//  MiscUtils.m
//  InAppPurchase
//
//  Created by TQI on 13/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "MiscUtils.h"

@implementation MiscUtils


+(NSString*) formatReal: (NSString*) valor eMostrarSimbolo:(BOOL) mostrarSimbolo {
    
    NSDecimalNumber *amountNumber = [NSDecimalNumber decimalNumberWithString:valor];
    
    NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    [currencyStyle setCurrencyCode:@"BRL"];
    [currencyStyle setCurrencyDecimalSeparator:@","];
    [currencyStyle setGroupingSeparator:@"."];
    
    if(mostrarSimbolo)
        [currencyStyle setCurrencySymbol:@"R$"];
    else
        [currencyStyle setCurrencySymbol:@""];
    
    [currencyStyle setNumberStyle: NSNumberFormatterCurrencyStyle];
    [currencyStyle setMaximumFractionDigits:2];
    [currencyStyle setRoundingMode: NSNumberFormatterRoundDown];
    NSString *currency = [currencyStyle stringFromNumber:amountNumber];
    return currency;
    
    
}

+(NSString*) formatStringDecimal: (NSString*) stringSemFormato {
    
    NSMutableString *strFormatada = [[NSMutableString alloc] initWithString:stringSemFormato];
    NSInteger tamanhoSemFormato = [stringSemFormato length];
    
    if(tamanhoSemFormato > 2 ) {
        [strFormatada insertString:@"." atIndex: (tamanhoSemFormato -2)];
    } else if(tamanhoSemFormato == 2) {
        [strFormatada insertString:@"0." atIndex: 0];
    } else if(tamanhoSemFormato == 1) {
        [strFormatada insertString:@"0.0" atIndex: 0];
    }
    
    return strFormatada;
}


+(NSString *)formatValueDecimal:(NSString *)valor{
    
    valor =[valor stringByReplacingOccurrencesOfString:@"."
                                            withString:@""];
    valor =[valor stringByReplacingOccurrencesOfString:@","
                                            withString:@""];
    valor =[valor stringByReplacingOccurrencesOfString:@"R$"
                                            withString:@""];
    
    
    valor = [self formatStringDecimal:valor];
    
    return valor;
    
    
}

+ (UIImage*) fitImage:(UIImage*)image inBox:(CGSize)size withBackground:(UIColor*)color {
    
    float widthFactor = size.width / image.size.width;
    float heightFactor = size.height / image.size.height;
    
    CGSize scaledSize = size;
    if (widthFactor<heightFactor) {
        scaledSize.width = size.width;
        scaledSize.height = image.size.height * widthFactor;
    } else {
        scaledSize.width = image.size.width * heightFactor;
        scaledSize.height = size.height;
    }
    
    UIGraphicsBeginImageContextWithOptions( size, NO, 0.0 );
    
    float marginX = (size.width-scaledSize.width)/2;
    float marginY = (size.height-scaledSize.height)/2;
    CGRect scaledImageRect = CGRectMake(marginX, marginY, scaledSize.width, scaledSize.height );
    
    UIImage* temp = UIGraphicsGetImageFromCurrentImageContext();
    [color set];
    UIRectFill(CGRectMake(0.0, 0.0, temp.size.width, temp.size.height));
    [image drawInRect:scaledImageRect];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
