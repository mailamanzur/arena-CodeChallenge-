//
//  PullRequest.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "PullRequest.h"
#import "Owner.h"

@implementation PullRequest
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"pullRequestName" : @"title",
             @"pullRequestDescription" : @"body",
             @"owner" : @"user"
             };
}

+ (NSValueTransformer *)ownerJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[Owner class]];
}

@end
