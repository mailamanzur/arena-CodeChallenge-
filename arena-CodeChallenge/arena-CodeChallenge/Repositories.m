//
//  Repositories.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "Repositories.h"
#import "Owner.h"

@implementation Repositories

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
              @"repositoryName" : @"name",
              @"repositoryDescription" : @"description",
              @"repositoryStars" : @"stargazers_count",
              @"repositoryForks" : @"forks",
              @"owner" : @"owner"
              };
}

+ (NSValueTransformer *)ownerJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[Owner class]];
}

@end
