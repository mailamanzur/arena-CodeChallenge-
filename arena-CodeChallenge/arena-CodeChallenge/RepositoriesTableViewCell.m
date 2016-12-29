//
//  RepositoriesTableViewCell.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "RepositoriesTableViewCell.h"
#import "Repositories.h"
#import "Owner.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RepositoriesTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *repositoryName;
@property (weak, nonatomic) IBOutlet UILabel *repositoryDescription;
@property (weak, nonatomic) IBOutlet UILabel *repositoryForks;
@property (weak, nonatomic) IBOutlet UILabel *repositoryStars;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UIImageView *ownerAvatar;

@end
@implementation RepositoriesTableViewCell

-(void)setup:(id)object {
    Repositories *repository = (Repositories *)object;
    NSURL *url = [NSURL URLWithString:repository.owner.ownerAvatar];
    
    _repositoryName.text = repository.repositoryName;
    _repositoryDescription.text = repository.repositoryDescription;
    _repositoryForks.text = [NSString stringWithFormat:@"Forks: %@", repository.repositoryForks];
    _repositoryStars.text = [NSString stringWithFormat:@"Stars: %@", repository.repositoryStars];
    _ownerName.text = repository.owner.ownerUsername;
    [_ownerAvatar sd_setImageWithURL:url];
}

+(CGFloat)cellHeight {
    return 112.0;
    
}


@end
