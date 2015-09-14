//
//  NSURL+Download.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "NSURL+DownloadFromAddress.h"

@implementation NSURL (DownloadFromAddress)
+(void)downloadFromAddress:(NSString*)address
                completion:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:address]
                                        completionHandler:completionHandler];
    
    [dataTask resume];
}


@end
