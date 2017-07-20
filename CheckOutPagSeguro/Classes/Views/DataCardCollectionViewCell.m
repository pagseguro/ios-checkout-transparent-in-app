//
//  DataCardCollectionViewCell.m
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "DataCardCollectionViewCell.h"
#import "DataCardViewController.h"
#import "PaymentViewController.h"
#import "PaymentConclusionViewController.h"


#define UIColorFromHex(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

static int counterView;

@implementation DataCardCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
    
    
}
+(int)getCounterView{
    
    return counterView;
}

+(void)setCounterView:(int)counter{
    
    counterView=counter;
}

-(void)setup{
    
    [self setLayoutViews:self.viewData];
    [self setLayoutViews:self.btnBack];
    [self setLayoutViews:self.btnNext];
    
    counterView=0;
    
    self.viewData.tag =counterView;
    
    
    [self.txtExpireDate setHidden:YES];
    [self.txtCVV setHidden:YES];
    [self.txtNameUser setHidden:YES];
    
    
    [self.lblCVV setHidden:YES];
    [self.lblNumbercard setHidden:NO];
    [self.lblExpireDate setHidden:NO];
    [self.lblExpireDateMessage setHidden:NO];
    
    self.guidedView.dataSource = self;
    self.guidedView.delegate = self;
    
    self.txtCVV.delegate=self;
    self.txtExpireDate.delegate=self;
    self.txtNumbercard.delegate=self;
    self.txtNameUser.delegate=self;
    
    
    self.guidedView.lineColor = UIColorFromHex(0x49872F);
    self.guidedView.backgroundLineColor = UIColorFromHex(0x90EE90);
    
    
}

-(void)setLayoutViews:(UIView*)view{
    
    
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 3;
    view.layer.shadowOpacity = 0.7;
    view.layer.cornerRadius = 5;
    
}




- (IBAction)btnBack:(id)sender {
    
    
    if (counterView>0) {
        
        if (self.viewData.tag==2) {
            [self imageCardNumber];
        }
        counterView--;
        
        [self segmentedControlWasTouched:counterView];
        self.viewData.tag= counterView;
        
        [UIView transitionWithView:  self.viewData
                          duration: 1.0
                           options: UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            
                            self.viewData.transform = CGAffineTransformMakeRotation(0);
                            if ( self.viewData.tag==0) {
                                self.lblData.text = @"Número do Cartão";
                                
                                [self.txtNumbercard setHidden:NO];
                                [self.txtExpireDate setHidden:YES];
                                [self.txtCVV setHidden:YES];
                                [self.txtNameUser setHidden:YES];
                                
                            }else  if ( self.viewData.tag==1) {
                                
                                self.lblData.text = @"Data de Validade";
                                
                                [self.txtNumbercard setHidden:YES];
                                [self.txtExpireDate setHidden:NO];
                                [self.txtCVV setHidden:YES];
                                [self.txtNameUser setHidden:YES];
                                
                                
                            }else  if ( self.viewData.tag==2) {
                                
                                [self.txtNumbercard setHidden:YES];
                                [self.txtExpireDate setHidden:YES];
                                [self.txtCVV setHidden:NO];
                                [self.txtNameUser setHidden:YES];
                                
                                
                                self.lblData.text = @"CVV";
                                
                                //[self btnPaymentHiddenYes];
                                
                                [self imageCardCVV];
                                
                            }else  if ( self.viewData.tag==3) {
                                
                                [self.txtNumbercard setHidden:YES];
                                [self.txtExpireDate setHidden:YES];
                                [self.txtCVV setHidden:YES];
                                [self.txtNameUser setHidden:NO];
                                
                                
                                self.lblData.text = @"Nome";
                            }else  if ( self.viewData.tag==4) {
                                
                                [self paymentController];
                                
                            }
                        }
                        completion:^(BOOL finished) {
                            
                        }
         ];
        
        
    }
    
}
- (IBAction)btnNext:(id)sender {
    
    
    if (counterView<4) {
        
        
        if (self.viewData.tag==2) {
            [self imageCardNumber];
        }
        counterView++;
        self.viewData.tag= counterView;
        
        [self segmentedControlWasTouched:counterView];
        
        
        
        [UIView transitionWithView:  self.viewData
                          duration: 1.0
                           options: UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            
                            self.viewData.transform = CGAffineTransformMakeRotation(0);
                            if ( self.viewData.tag==0) {
                                self.lblData.text = @"Número do Cartão";
                                
                                [self.txtNumbercard setHidden:NO];
                                [self.txtExpireDate setHidden:YES];
                                [self.txtCVV setHidden:YES];
                                [self.txtNameUser setHidden:YES];
                                
                                
                            }else  if ( self.viewData.tag==1) {
                                
                                self.lblData.text = @"Data de Validade";
                                
                                [self.txtNumbercard setHidden:YES];
                                [self.txtExpireDate setHidden:NO];
                                [self.txtCVV setHidden:YES];
                                [self.txtNameUser setHidden:YES];
                                
                                
                            }else  if ( self.viewData.tag==2) {
                                
                                [self.txtNumbercard setHidden:YES];
                                [self.txtExpireDate setHidden:YES];
                                [self.txtCVV setHidden:NO];
                                [self.txtNameUser setHidden:YES];
                                
                                self.lblData.text = @"CVV";
                                [self imageCardCVV];
                                
                                //[self btnPaymentHiddenYes];
                                
                                
                            }else  if ( self.viewData.tag==3) {
                                
                                [self.txtNumbercard setHidden:YES];
                                [self.txtExpireDate setHidden:YES];
                                [self.txtCVV setHidden:YES];
                                [self.txtNameUser setHidden:NO];
                                
                                self.lblData.text = @"Nome";
                            }else  if ( self.viewData.tag==4) {
                                
                                [self paymentController];
                                
                            }
                        }
                        completion:^(BOOL finished) {
                            
                        }
         ];
        
    }
    
}



-(void)imageCardCVV{
    
    
    
    [UIView transitionWithView:  self.imageViewCard
                      duration: 1.0
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        // My flip specific code
                        self.imageViewCard.transform = CGAffineTransformMakeRotation(0);
                        self.imageViewCard.image = [UIImage imageNamed:@"card-back.png"];
                        
                        [self.lblNumbercard setHidden:YES];
                        [self.lblExpireDate setHidden:YES];
                        [self.lblExpireDateMessage setHidden:YES];
                        [self.lblNameUser setHidden:YES];
                        
                    }
                    completion:^(BOOL finished) {
                        
                        [self.lblCVV setHidden:NO];
                        
                    }
     ];
    
}

-(void)imageCardNumber{
    
    
    
    
    [UIView transitionWithView:  self.imageViewCard
                      duration: 1.0
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.imageViewCard.transform = CGAffineTransformMakeRotation(0);
                        self.imageViewCard.image = [UIImage imageNamed:@"card-front.png"];
                        
                        [self.lblCVV setHidden:YES];
                        
                    }
                    completion:^(BOOL finished) {
                        
                        [self.lblNumbercard setHidden:NO];
                        [self.lblExpireDate setHidden:NO];
                        [self.lblExpireDateMessage setHidden:NO];
                        [self.lblNameUser setHidden:NO];
                        
                    }
     ];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSString * digit1=   @"";
    NSString * digit2=   @"";
    NSString * digit3=    @"";
    if (self.txtNumbercard.text.length>2) {
        digit1=    [self.txtNumbercard.text substringWithRange: NSMakeRange(0, 1)];
        digit2=    [self.txtNumbercard.text substringWithRange: NSMakeRange(0, 2)];
        digit3=    [self.txtNumbercard.text substringWithRange: NSMakeRange(0, 3)];
        
    }
    
    if (textField == self.txtNumbercard) {
        
        
        if ([digit1 isEqualToString:@"4"]|| [digit1 isEqualToString:@"5"]) {
            //Visa e Master
            if (range.location >18) {
                return NO;
            }
            if (range.length == 0 && range.location == 4 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 9 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 14 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            self.txtNumbercard.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
            self.lblNumbercard.text = self.txtNumbercard.text;
            
            return NO;
        }else  if ([digit2 isEqualToString:@"34"] || [digit2 isEqualToString:@"37"]) {
            //Amex
            if (range.location >16) {
                return NO;
            }
            if (range.length == 0 && range.location == 4 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 11 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            
            self.txtNumbercard.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
            self.lblNumbercard.text = self.txtNumbercard.text;
            
            return NO;
        }else  if ([digit2 isEqualToString:@"36"]|| [digit2 isEqualToString:@"38"]||[digit2 isEqualToString:@"30"]||[digit3 isEqualToString:@"305"]) {
            //Diners
            if (range.location >16) {
                return NO;
            }
            if (range.length == 0 && range.location == 4 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 9 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 12 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            self.txtNumbercard.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
            self.lblNumbercard.text = self.txtNumbercard.text;
            
            return NO;
        }else{
            //outros
            if (range.location >18) {
                return NO;
            }
            if (range.length == 0 && range.location == 4 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 9 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            if (range.length == 0 && range.location == 14 ) {
                textField.text = [NSString stringWithFormat:@"%@ %@", textField.text,string];
                return NO;
            }
            self.txtNumbercard.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
            self.lblNumbercard.text = self.txtNumbercard.text;
            
            return NO;
        }
        
        
    }
    
    
    if (textField == self.txtExpireDate) {
        if (range.location >4) {
            return NO;
        }
        if (range.length == 0 && range.location == 2 ) {
            textField.text = [NSString stringWithFormat:@"%@/%@", textField.text,string];
            return NO;
        }
        self.txtExpireDate.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
        
        self.lblExpireDate.text = self.txtExpireDate.text;
        
        return NO;
    }
    
    if (textField == self.txtCVV) {
        if (range.location >3) {
            return NO;
        }
        
        self.txtCVV.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
        
        self.lblCVV.text = self.txtCVV.text;
        
        return NO;
    }
    
    if (textField == self.txtNameUser) {
        
        
        self.txtNameUser.text = [[textField text] stringByReplacingCharactersInRange:range withString:string];
        
        self.lblNameUser.text = self.txtNameUser.text;
        
        return NO;
    }
    
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height<=568) {
        [[DataCardViewController sharedInstance:nil] setScrollTextField];
        
    }
    
    return YES;
}



-(NSString*) formataStringPadraoCasaDecimal: (NSString*) stringSemFormato {
    
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

-(NSString*) formataPadraoReal: (NSString*) valor eMostrarSimbolo:(BOOL) mostrarSimbolo {
    
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


-(void)startProgressBar:(UIView*)view{
    
    UIView * viewNew  = [[UIView alloc]init];
    viewNew.tag  = 1;
    
    viewNew.frame =CGRectMake(round((view.frame.size.width - 120) / 2), round((view.frame.size.height - 120) / 2), 120, 120);
    
    UIImage * image  = [UIImage imageNamed:@"background"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(round((viewNew.frame.size.width - 120) / 2), round((viewNew.frame.size.height - 120) / 2), 120, 120);
    
    [viewNew addSubview:imageView];
    
    UIActivityIndicatorView  *av = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
    av.frame = CGRectMake(round((viewNew.frame.size.width - 25) / 2), round((viewNew.frame.size.height - 25) / 2), 25, 25);
    
    av.transform = CGAffineTransformMakeScale(2.5, 2.5);
    
    [viewNew addSubview:av];
    
    [view addSubview:viewNew];
    [av startAnimating];
    
    viewNew.layer.masksToBounds = YES;
    viewNew.layer.cornerRadius = 10;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
}


-(void)stopProgressBar:(UIView*)view{
    
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[view viewWithTag:1];
    [tmpimg removeFromSuperview];
}


- (IBAction)payment:(id)sender {
    
    
    
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

-(void)paymentController{
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PaymentViewController *paymentViewController = [board instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    
    paymentViewController.numberCard=self.lblNumbercard.text;
    paymentViewController.expireDate=self.lblExpireDate.text;
    paymentViewController.nameUser=self.txtNameUser.text;
    paymentViewController.CVV=self.lblCVV.text;
    
    paymentViewController.itemPayment = self.itemPayment;
    
    [self.viewController pushViewController:paymentViewController animated:YES];
}




@end
