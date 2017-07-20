//
//  HomeViewController.m
//  Transparent
//
//  Created by TQI on 03/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import "HomeViewController.h"
#import "HomecardCollectionViewCell.h"
#import "DetailItemViewController.h"
#import "MiscUtils.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>{
    
    NSMutableArray * itemsPurchase;

}


@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleHome;

@end



@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self inicializaGesto];

    [self setup];
    
    NSDictionary *params = @{ @"items": @[
                                      @{
                                          @"image": @"note_prata",
                                          @"description": @"Intel® Core™ i7 Quad Core 14.0\" FullHD+ 16:9Ratio 2.2GHZ - 8GB - 128GB SATA III SSD",
                                          @"value": @"3.0",
                                          @"name": @"Notebook Prata"
                                          },
                                      @{
                                          @"image": @"note_rosa",
                                          @"description": @"Intel® Core™ i7 Quad Core 14.0\" FullHD+ 16:9Ratio 2.2GHZ - 16GB - 256GB SATA III SSD",
                                          @"value": @"3200.0",
                                          @"name": @"Notebook Rosa"
                                          }, @{
                                          @"image": @"note_preto",
                                          @"description": @"Intel® Core™ i7 Quad Core 14.0\" FullHD+ 16:9Ratio 2.2GHZ - 32GB - 512GB SATA III SSD",
                                          @"value": @"4100.0",
                                          @"name": @"Notebook Preto"
                                          }, @{
                                          @"image": @"note_prata",
                                          @"description": @"Intel® Core™ i7 Quad Core 14.0\" FullHD+ 16:9Ratio 2.8GHZ - 16GB - 1024GB SATA III SSD",
                                          @"value": @"5800.0",
                                          @"name": @"Notebook Prata"
                                          }
                                      ]
                             
                             };

    itemsPurchase= [[NSMutableArray alloc]init];
    
    itemsPurchase = [params[@"items"] copy];
   

    

}
- (void)viewDidAppear:(BOOL)animated{

}

-(void) inicializaGesto {
    UIGestureRecognizer *gesto  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickForaTeclado)];
    gesto.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gesto];
}



-(void)clickForaTeclado {
    [self.view  endEditing:YES];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if (result.height<=480) {
        self.homeCollectionView.contentOffset = CGPointMake(0, 5);
    }

}

- (void)setup{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(120   , 120)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width  , 150);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 1;

    [self.homeCollectionView setCollectionViewLayout:flowLayout];
    
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"HomecardCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomecardCollectionViewCell_XIB"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [itemsPurchase count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     
     @"image": @"note_prata",
     @"description": @"Intel® Core™ i7 Quad Core 14.0\" FullHD+ 16:9Ratio 2.2GHZ - 8GB - 128GB SATA III SSD",
     @"value": @"2199.0",
     @"name": @"Notebook Prata"
     */
    
     NSDictionary   * elemento = [itemsPurchase  objectAtIndex:indexPath.row];
    
    HomecardCollectionViewCell *cell = (HomecardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomecardCollectionViewCell_XIB" forIndexPath:indexPath];
    
    CGSize newSize =   CGSizeMake (110  , 110);
    cell.imageItem.image = [MiscUtils fitImage:[UIImage imageNamed:elemento[@"image"]] inBox:newSize withBackground:[UIColor whiteColor]];
    cell.valueItem.text =[MiscUtils formatReal: elemento[@"value"] eMostrarSimbolo:YES];
     cell.descriptionItem.text =elemento[@"description"];
     cell.nameItem.text =elemento[@"name"];
            return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *board;
    
    if (!self.storyboard)
    {
        board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    else
    {
        board = self.storyboard;
    }
   
    DetailItemViewController *paymentViewController = [board instantiateViewControllerWithIdentifier:@"DetailItemViewController"];
    paymentViewController.itemSelected =[itemsPurchase  objectAtIndex:indexPath.row];
   
    [self.navigationController pushViewController:paymentViewController animated:YES];

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}





@end
