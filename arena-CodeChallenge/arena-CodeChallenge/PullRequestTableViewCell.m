//
//  PullRequestTableViewCell.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "PullRequestTableViewCell.h"
#import "Owner.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PullRequest.h"

@interface PullRequestTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *pullRequestName;
@property (weak, nonatomic) IBOutlet UILabel *pullRequestDescription;
@property (weak, nonatomic) IBOutlet UIImageView *ownerAvatar;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@end

@implementation PullRequestTableViewCell

-(void)setup:(id)object {
    
    PullRequest *pullRequest = (PullRequest *)object;
    NSURL *url = [NSURL URLWithString:pullRequest.owner.ownerAvatar];
    
    _pullRequestName.text = pullRequest.pullRequestName;
    _pullRequestDescription.text = pullRequest.pullRequestDescription;
    _ownerName.text = pullRequest.owner.ownerUsername;
    [_ownerAvatar sd_setImageWithURL:url];
}

+(CGFloat)cellHeight {
    return 124.0;
    
}

@end
