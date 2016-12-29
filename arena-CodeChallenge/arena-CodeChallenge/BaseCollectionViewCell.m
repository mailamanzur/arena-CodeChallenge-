//
//  BaseCollectionViewCell.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

+(CGSize)cellSize{
    return CGSizeMake(0, 0);
}

+(NSString *)cellIdentifier{
    NSString *identifier = NSStringFromClass(self.class);
    return identifier;
}

-(void)setup:(id)object{
    
}

+(void)registerForCollectionView:(UICollectionView *)collectionview{
    NSString *identifier = NSStringFromClass(self.class);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionview registerNib:nib forCellWithReuseIdentifier:identifier];
}

@end
