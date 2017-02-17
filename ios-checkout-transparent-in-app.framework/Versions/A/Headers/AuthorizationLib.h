//
//  AuthorizationLib.h
//  CarteiraPagamentoLib
//
//  Created by Ricardo Borelli
//  Copyright (c) 2016 PagSeguro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorizationLib : NSObject

@property NSString *email;
@property NSString *token;

+ (id)sharedManager;

- (void)setEmail:(NSString *)email withToken:(NSString *)token ;

@end
