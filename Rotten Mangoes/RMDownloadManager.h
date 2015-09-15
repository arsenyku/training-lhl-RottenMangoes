//
//  RMDownloadManager.h
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMDownloadManager : NSObject
-(int)trackDownloadWithUrl:(NSString*)url;
-(void)completeDownloadWithURL:(NSString*)url;
-(int)trackingNumberForURL:(NSString*)url;

+ (id)sharedManager;
@end
