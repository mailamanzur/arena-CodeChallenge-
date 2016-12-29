//
//  ApiNetworkingManager.h
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^SuccessBlock)(NSURLSessionTask *operation, id responseObject);
typedef void (^FailureBlock)(NSURLSessionTask *operation, NSError *error, NSString *customErrorMessage);

@interface ApiNetworkingManager : NSObject

-(void)setupWithHttps;

-(void) GET:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
    failure:(FailureBlock)failure;

-(void) POST:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
     failure:(FailureBlock)failure;

-(void) PUT:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
    failure:(FailureBlock)failure;

-(void) DELETE:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
       failure:(FailureBlock)failure;

@end
