//
//  AFMovieDbClient.m
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import "AFMovieDbClient.h"


@implementation AFMovieDbClient

+ (instancetype)sharedInstance {
    static AFMovieDbClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[AFMovieDbClient alloc] initWithBaseURL:[NSURL URLWithString:kMovieDbBaseURL]];
        _sharedInstance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedInstance;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSMutableDictionary*)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    if (!parameters) {
        parameters = [@{@"api_key": kMovieDbAPIKey}mutableCopy];;
    }
    else{
        [parameters setObject:kMovieDbAPIKey forKey:@"api_key"];
    }
    return [super GET:URLString parameters:parameters success:success failure:failure];
}
@end
