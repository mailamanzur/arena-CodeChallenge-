//
//  NetworkingConstants.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "NetworkingConstants.h"

# pragma mark - Base
NSString *const kApiBaseURL = @"http://api.github.com/search/repositories?q=language:Java&sort=stars&page=%@";

# pragma mark - Pull Requests
NSString *const kApiPullRequest = @"http://api.github.com/repos/%@/%@/pulls";


# pragma mark - HTTP Status code
NSString *const kBadRequestStatus = @"400";
NSString *const kUnauthorizedStatus = @"401";
NSString *const kForbiddenStatus = @"403";
NSString *const kNotFoundStatus = @"404";
NSString *const kConflictStatus = @"409";
NSString *const kPreconditionFailedStatus = @"412";
NSString *const kInternalServerErrorStatus = @"500";
NSString *const kServiceUnavailableStatus = @"503";

