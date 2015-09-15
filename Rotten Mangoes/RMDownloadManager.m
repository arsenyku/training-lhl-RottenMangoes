//
//  RMDownloadManager.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMDownloadManager.h"
@interface RMDownloadManager()
@property(nonatomic,strong)NSMutableDictionary *downloads;
@property(nonatomic,assign)int lastTrackingNumber;
@end

@implementation RMDownloadManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        _downloads = [NSMutableDictionary new];
        _lastTrackingNumber = 0;
    }
    return self;
}

-(int)trackingNumberForURL:(NSString*)url{
    NSNumber *result = self.downloads[url];
    return [result intValue];
}

-(int)trackDownloadWithUrl:(NSString*)url{
    self.lastTrackingNumber += 1;
    self.downloads[ url ] = [NSNumber numberWithInt:self.lastTrackingNumber];
    return self.lastTrackingNumber;
}

-(void)completeDownloadWithURL:(NSString*)url{
    [self.downloads removeObjectForKey:url];
}


+ (instancetype)sharedManager {
    static RMDownloadManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

@end
