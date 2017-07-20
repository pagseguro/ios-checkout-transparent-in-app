//
//  HomecardCollectionViewCell.h
//  CollectionHome
//
//  Created by TQI on 08/02/17.
//  Copyright © 2017 Luis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomecardCollectionViewCell : UICollectionViewCell<UITextFieldDelegate>{

}
@property (weak, nonatomic) IBOutlet UIView *viewItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageItem;
@property (weak, nonatomic) IBOutlet UILabel *nameItem;
@property (weak, nonatomic) IBOutlet UILabel *descriptionItem;
@property (weak, nonatomic) IBOutlet UILabel *valueItem;



@end
