//
//  BaseCollectionViewCell.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

+(CGSize)cellSize;

+(NSString *)cellIdentifier;

-(void)setup:(id)object;

+(void)registerForCollectionView:(UICollectionView *)collectionview;

@end
