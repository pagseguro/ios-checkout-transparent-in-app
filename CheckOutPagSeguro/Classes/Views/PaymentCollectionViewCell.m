//
//  PaymentCollectionViewCell.m
//  InAppPurchase
//
//  Created by TQI on 13/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "PaymentCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "PaymentConclusionViewController.h"
#import "MiscUtils.h"

#define UIColorFromHex(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation PaymentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setLayoutViews:self.btnConfirmation ];
    [self setLayoutViews:self.itemSelected];
    [self setLayoutViews:self.descriptionValue];
    [self setLayoutViews:self.dadosCard];
    
    
    
    self.guidedView.dataSource = self;
    self.guidedView.delegate = self;
    self.guidedView.lineColor = UIColorFromHex(0x49872F);
    self.guidedView.backgroundLineColor = UIColorFromHex(0x90EE90);
    
}

-(void)setup{
    [self.guidedView selectNodeAtIndex:4];
    
    
}

-(void)setLayoutViews:(UIView*)view{
    
    
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 3;
    view.layer.shadowOpacity = 0.7;
    view.layer.cornerRadius = 5;
    
}

- (void)segmentedControlWasTouched:(int)selectedSegmentIndex {
    
    [self.guidedView selectNodeAtIndex:selectedSegmentIndex];
}

- (BOOL)guidedView:(UIGuidedView *)guidedView willSingleTransitionFromIndex:(NSInteger)index toIndex:(NSInteger)toIndex inDirection:(UIGuidedViewAnimationDirection)direction{
    
    NSLog(@"Will single transition from %li to %li", (long)index, (long)toIndex);
    
    return YES;
}

- (BOOL)guidedView:(UIGuidedView *)guidedView willMultipleTransitionFromIndex:(NSInteger)index toIndex:(NSInteger)toIndex inDirection:(UIGuidedViewAnimationDirection)direction{
    
    NSLog(@"Will multiple transition from %li to %li", (long)index, (long)toIndex);
    
    return YES;
}

- (void)guidedView:(UIGuidedView *)guidedView didSingleTransitionFromIndex:(NSInteger)index toIndex:(NSInteger)toIndex inDirection:(UIGuidedViewAnimationDirection)direction{
    
    NSLog(@"Did single transition from %li to %li", (long)index, (long)toIndex);
}

- (void)guidedView:(UIGuidedView *)guidedView didMultipleTransitionFromIndex:(NSInteger)index toIndex:(NSInteger)toIndex inDirection:(UIGuidedViewAnimationDirection)direction{
    
    NSLog(@"Did multiple transition from %li to %li", (long)index, (long)toIndex);
}

#pragma mark - UIGuidedViewDataSource

- (NSInteger)numberOfNodesForGuidedView:(UIGuidedView *)view {
    return 5;
}

- (NSString *)guidedView:(UIGuidedView *)guidedView titleForNodeAtIndex:(NSInteger)index {
    
    NSString *title = @"";
    
    if(index == 0){
        title = @"Num. Cartão";
    }else if (index == 1){
        title = @"Validade";
    }else if (index == 2){
        title = @"CVV";
    }else if (index == 3){
        title = @"Nome";
    }else if (index == 4){
        title = @"Pagamento";
    }
    
    return title;
}



- (IBAction)btnConfirmation:(id)sender {
    
    
    [[AuthorizationLib sharedManager] setEmail:@"<email do Vendedor>" withToken:@"<token do Vendedor>" ];
    
    NSString * cardCreditFormatted = [self.numberCard stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * month=@"";
    NSString * year=@"";
    
    
    if (self.lblExpireDate.text.length>0) {
        NSArray * date = [self stringToArray:self.lblExpireDate.text];
        month= [NSString stringWithFormat:@"%@",[date objectAtIndex:0]];
        year=[NSString stringWithFormat:@"%@",[date objectAtIndex:1]];
    }
    
    
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.checkoutTransparent = [[CheckoutTransparent alloc] initWithCreditCard:cardCreditFormatted
                                                                      expMonth:month
                                                                       expYear:year
                                                                           cvv:self.CVV
                                                                 amountPayment:[MiscUtils formatValueDecimal:self.lblValueAll.text]
                                                            descriptionPayment:@"pagamento de roupa"
                                                                       success:^(BOOL approved, NSDictionary *success){
                                                                           
                                                                           NSLog(@"ApprovalResult");
                                                                           
                                                                           // [self alerta:@"Pagamento efetuado com sucesso!"];
                                                                           [MBProgressHUD hideHUDForView:self animated:YES];
                                                                           
                                                                           [self paymentoConclusion:@"ICN_CONF" message:@"Seu pagamento foi aprovado!"];
                                                                           
                                                                           
                                                                       } failure:^(NSError *error) {
                                                                           [MBProgressHUD hideHUDForView:self animated:YES];
                                                                           
                                                                           NSLog(@"RefusedResult");
                                                                           
                                                                           NSString * message = @"";
                                                                           
                                                                           if (error.userInfo[@"message"]) {
                                                                               message = [NSString stringWithFormat:@"%@",error.userInfo[@"message"]];
                                                                           }
                                                                           
                                                                           else if (error.userInfo[@"NSLocalizedDescription"]) {
                                                                               message = [NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]];
                                                                           }
                                                                           
                                                                           
                                                                           if (message.length==0 || [message isEqualToString:@"(null)"]) {
                                                                               message=@"Erro ao efetuar pagamento!";
                                                                           }
                                                                           [self paymentoConclusion:@"ICN_ERROR" message:message];
                                                                           
                                                                       }];
    
    
    
    
}
-(void)paymentoConclusion:(NSString*)image message:(NSString *)message{
    
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PaymentConclusionViewController *paymentViewController = [board instantiateViewControllerWithIdentifier:@"PaymentConclusionViewController"];
    
    paymentViewController.imageConclusionResponse=image;
    paymentViewController.messageConclusionResponse=message;
    
    [self.viewController pushViewController:paymentViewController animated:YES];
}

- (NSArray*) stringToArray:(NSString*)str
{
    NSString *sep = @"/";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:sep];
    NSArray *temp=[str componentsSeparatedByCharactersInSet:set];
    
    NSMutableArray* numbers = [[NSMutableArray alloc] init];
    for (NSString* s in temp) {
        NSNumber *n = [NSNumber numberWithInteger:[s integerValue]];
        [numbers addObject:n];
    }
    
    return numbers;
}


@end
