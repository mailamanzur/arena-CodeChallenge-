//
//  PullRequest.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "BaseMantleObject.h"
@class Owner;
@interface PullRequest : BaseMantleObject
@property(nonatomic, strong) NSString *pullRequestName;
@property(nonatomic, strong) NSString *pullRequestDescription;
@property(nonatomic, strong) Owner *owner;


@end
