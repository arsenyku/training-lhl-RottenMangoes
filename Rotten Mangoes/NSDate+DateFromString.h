//
//  NSDate+DateFromString.h
//  Rotten Mangoes
//
//  Created by asu on 2015-09-15.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateWithFormattedString)
+(NSDate*)dateFromString:(NSString*)dateString withFormat:(NSString*)format;

@end
