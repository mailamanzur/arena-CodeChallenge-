//
//  Repositories.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "BaseMantleObject.h"

@class Owner;
@interface Repositories : BaseMantleObject

@property(nonatomic, strong) NSString *repositoryName;
@property(nonatomic, strong) NSString *repositoryDescription;
@property(nonatomic, strong) NSNumber *repositoryStars;
@property(nonatomic, strong) NSNumber *repositoryForks;
@property(nonatomic, strong) Owner *owner;

@end
