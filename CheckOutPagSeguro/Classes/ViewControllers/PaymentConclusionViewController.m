//
//  PaymentConclusionViewController.m
//  InAppPurchase
//
//  Created by TQI on 09/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "PaymentConclusionViewController.h"
#import "HomeViewController.h"

@interface PaymentConclusionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageConclusion;
@property (weak, nonatomic) IBOutlet UILabel *txtConclusion;
@property (weak, nonatomic) IBOutlet UIButton *btnConclusion;

- (IBAction)btnConclusion:(id)sender;

@end

@implementation PaymentConclusionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.messageConclusionResponse==nil && [self.imageConclusionResponse isEqualToString:@"ICN_ERROR"]) {
      self.messageConclusionResponse = @"Erro ao efetuar pagamento!";
    }
    
    
    
    self.imageConclusion.image = [UIImage imageNamed:self.imageConclusionResponse];
    self.txtConclusion.text = self.messageConclusionResponse;
    [self setLayoutViews:self.btnConclusion];
    
}


-(void)setLayoutViews:(UIView*)view{
    
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 10;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)btnConclusion:(id)sender {
    
    if ([self.imageConclusionResponse isEqualToString:@"ICN_ERROR"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        UIStoryboard *board;
        
        if (!self.storyboard)
        {
            board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        }
        else
        {
            board = self.storyboard;
        }
        
        HomeViewController *homeViewController = [board instantiateViewControllerWithIdentifier:@"HomeViewController"];
        
        
        [self.navigationController pushViewController:homeViewController animated:YES];
        
        
    }
    
    
}


@end
