//
//  RepositoriesApiManager.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 29/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "ApiNetworkingManager.h"

typedef void (^RepositoriesSuccessBlock)(id response);
typedef void (^RepositoriesFailureBlock)(NSString *errorMsg);

@interface RepositoriesApiManager : ApiNetworkingManager

+ (RepositoriesApiManager *)sharedManager;

- (void)fetchRepositoriesWithPage:(NSNumber *)page
                          Success:(RepositoriesSuccessBlock)success
                          Failure:(RepositoriesFailureBlock)failure;


- (void)fetchPullRequestsWithUser:(NSString *)owner
                    andRepository:(NSString *)repository
                          Success:(RepositoriesSuccessBlock)success
                          Failure:(RepositoriesFailureBlock)failure;
@end
