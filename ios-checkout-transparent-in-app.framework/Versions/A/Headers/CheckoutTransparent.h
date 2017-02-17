//
//  CheckoutTransparent.h
//  ios-checkout-transparent-in-app
//
//  Created by TQI on 16/02/17.
//  Copyright © 2017 PagSeguro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ApprovalResultBlock)(BOOL approved, NSDictionary * success);
typedef void(^RefusedResultBlock)(NSError *error);

@interface CheckoutTransparent : NSObject

-(void)psWalletDidFinishPayment;

- (instancetype)initWithCreditCard:(NSString*)creditCard
                          expMonth:(NSString *)expMonth
                           expYear:(NSString *)expYear
                               cvv:(NSString *)cvv
                     amountPayment:(NSString *)amountPayment
                descriptionPayment:(NSString *)descriptionPayment
                           success:(ApprovalResultBlock)success
                           failure:(RefusedResultBlock)failure;


/*
 DESCRIÇÃO DE ERROS LIB
 
 1001 - INVALID CARD NUMBER (Número do cartão inválido);
 
 1002 - YEAR OF VALIDATION OF THE INVALID CARD (Ano de validade do cartão inválido);
 
 1003 - VALID MONTH OF INVALID CARD (Mês de validade do cartão inválido);
 
 1004 - VALUE OF INVALID PAYMENT (Valor do pagamento inválido);
 
 1005 - INVALID CVV NUMBER (Número do cvv inválido);
 
 9000 - NETWORK_ERROR (Falha de conexão);
 
 9001 - REFUSED_TRANSACTION_ERROR (Transação cancelada ou recusada);
 
 9002 - CREATE_TRANSACTION_ERROR (Falha ao criar transação);
 
 9003 - TIME_OUT_CHECK_TRANSACTION (Timeout verificação status da transação);
 
 9004 - CHECK_TRANSACTION_ERROR (Falha na verificação da transação);
 
 9005 - TIME_OUT_CHECK_TRANSACTION_VALIDATOR (Timeout verificação status da transação validadora);
 */



@end
