//
//  ApiNetworkingManager.m
//  arena-CodeChallenge
//
//  Created by Maila  Manzur on 26/12/16.
//  Copyright © 2016 Maila  Manzur. All rights reserved.
//

#import "ApiNetworkingManager.h"
#import "NSString+Utils.h"
#import "NetworkingConstants.h"

@interface ApiNetworkingManager ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) NSURL *baseURL;

@end

@implementation ApiNetworkingManager

-(void)setupWithHttps{
    [self setupRequestOperationManager];
    [self setupRequestSerializers];
}

-(void)addHeader:(NSString *)value forKey:(NSString *)key{
    [_manager.requestSerializer setValue:value  forHTTPHeaderField:key];
}

-(void) GET:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
    failure:(FailureBlock)failure{
    
    [_manager GET:[url asEscapedURL] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self handleFailure:task error:error failure:failure];
    }];
}

-(void) POST:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
     failure:(FailureBlock)failure{
    
    [_manager POST:[url asEscapedURL] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailure:task error:error failure:failure];
    }];
}

-(void) PUT:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
    failure:(FailureBlock)failure{
    
    [_manager PUT:[url asEscapedURL] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailure:task error:error failure:failure];
    }];
}

-(void) DELETE:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success
       failure:(FailureBlock)failure{
    [_manager DELETE:[url asEscapedURL] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailure:task error:error failure:failure];
    }];
    
}

#pragma mark - Private Methods

-(void)handleFailure:(NSURLSessionTask *)task error:(NSError*)error failure:(FailureBlock)failure{
    NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *) task.response;
    NSInteger statusCode = HTTPresponse.statusCode;
    
    NSString *customErrorMessage = nil;
    if(statusCode == [kBadRequestStatus integerValue]){
        customErrorMessage = @"Bad Request Status";
    }else if(statusCode == [kUnauthorizedStatus integerValue]){
        customErrorMessage = @"Unauthorized Status";
    }else if(statusCode == [kForbiddenStatus integerValue]){
        customErrorMessage = @"Forbidden Status";
    }else if(statusCode == [kNotFoundStatus integerValue]){
        customErrorMessage = @"Not Found Status";
    }else if(statusCode == [kConflictStatus integerValue]){
        customErrorMessage = @"Conflict Status";
    }else if(statusCode == [kPreconditionFailedStatus integerValue]){
        customErrorMessage = @"Precondition Failed Status";
    }else if(statusCode == [kInternalServerErrorStatus integerValue]){
        customErrorMessage = @"Internal Server Error Status";
    }else if(statusCode == [kServiceUnavailableStatus integerValue]){
        customErrorMessage = @"Service Unavailable Status";
    }
    
    failure(task,error,customErrorMessage);
}

-(void)setupRequestOperationManager{
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kApiBaseURL]];
    [self shouldAllowInvalidSSLCertificates:YES];
}

-(void)shouldAllowInvalidSSLCertificates:(BOOL)accept{
    _manager.securityPolicy.allowInvalidCertificates = accept;
}

-(void)configureReachability {
    NSOperationQueue *operationQueue = _manager.operationQueue;
    [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [operationQueue setSuspended:NO];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
}

-(void)setupRequestSerializers{
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
}

@end
