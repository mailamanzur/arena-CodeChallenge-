//
//  RepositoriesApiManager.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "RepositoriesApiManager.h"
#import "Repositories.h"


@implementation RepositoriesApiManager

+(RepositoriesApiManager *)sharedManager {
    static RepositoriesApiManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(id)init {
    if (self = [super init]) {
        [self setupWithHttps];
    }
    return self;
}

#pragma mark - GET Methods
- (void)fetchRepositoriesWithPage:(NSNumber *)page
                          Success:(RepositoriesSuccessBlock)success
                          Failure:(RepositoriesFailureBlock)failure {
    
    NSString *finalURL = [NSString stringWithFormat:kApiBaseURL,page];
    
    [self GET:finalURL params:nil success:^(NSURLSessionTask *operation, id responseObject) {
        
        NSError *error;
        
        NSArray *response = [Repositories parseArray:responseObject[@"items"] error:&error];
        
        if (response)
            success(response);
        else
            success(nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error, NSString *customErrorMessage) {
        failure([error localizedDescription]);
    }];
}

@end
