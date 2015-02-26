//
//  AFMovieDbClient.h
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
@interface AFMovieDbClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;
/**
 *  Client for managing calls to MovieDb API, it automatically appends the API KEY to each request
 *
 *  @param URLString  url for the request
 *  @param parameters extra parametes for query string
 *  @param success    success block
 *  @param failure    failure block
 *
 *  @return Session object
 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSMutableDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
