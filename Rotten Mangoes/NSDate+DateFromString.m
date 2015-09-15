//
//  NSDate+DateFromString.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-15.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "NSDate+DateFromString.h"

@implementation NSDate (DateWithFormattedString)
+(NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateString];
}
@end
