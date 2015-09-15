//
//  RMReview.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-15.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMReview.h"
#import "NSDate+DateFromString.h"

static NSString* const ReviewKey_Critic = @"critic";
static NSString* const ReviewKey_Date = @"date";
static NSString* const ReviewKey_Score = @"original_score";
static NSString* const ReviewKey_Freshness = @"freshness";
static NSString* const ReviewKey_Publication = @"publication";
static NSString* const ReviewKey_Quote = @"quote";
static NSString* const ReviewKey_Links = @"links";

static NSString* const ReviewDateFormat = @"YYYY-MM-DD";


@implementation RMReview
-(instancetype)initWithDictionary:(NSDictionary*)data{
    self = [super init];
    if (self) {
        _criticName = data[ ReviewKey_Critic ];
        _date = [NSDate dateFromString:data[ ReviewKey_Date ] withFormat:ReviewDateFormat];
        _score = data[ ReviewKey_Score ];
        _freshness = data[ ReviewKey_Freshness ];
        _publication = data[ ReviewKey_Publication ];
        _quote = data[ ReviewKey_Quote ];
        _links = data[ ReviewKey_Links];
        
    
    }
    return self;
}

+(instancetype)movieWithDictionary:(NSDictionary*)data{
    return [[RMReview alloc] initWithDictionary:data];
}

@end
