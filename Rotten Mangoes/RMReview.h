//
//  RMReview.h
//  Rotten Mangoes
//
//  Created by asu on 2015-09-15.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMReview : NSObject
@property(nonatomic)NSString* criticName;
@property(nonatomic)NSDate* date;
@property(nonatomic)NSString* score;
@property(nonatomic)NSString* freshness;
@property(nonatomic)NSString* publication;
@property(nonatomic)NSString* quote;
@property(nonatomic)NSDictionary* links;

-(instancetype)initWithDictionary:(NSDictionary*)data;
+(instancetype)movieWithDictionary:(NSDictionary*)data;

@end
