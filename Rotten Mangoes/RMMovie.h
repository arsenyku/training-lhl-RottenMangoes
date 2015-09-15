//
//  Movie.h
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageType) {
    Original,
    Thumbnail,
    Profile,
    Detailed
};

@interface RMMovie : NSObject
@property(nonatomic, strong, readonly)NSString* identifier;
@property(nonatomic, strong, readonly)NSString* title;
@property(nonatomic, strong, readonly)NSNumber* year;
@property(nonatomic, strong, readonly)NSString* mpaaRating;
@property(nonatomic, strong, readonly)NSNumber* runtimeInMinutes;
@property(nonatomic, strong, readonly)NSString* synopsis;
@property(nonatomic, strong, readonly)NSDictionary* images;
@property(nonatomic, strong, readonly)NSDictionary* cast;

-(instancetype)initWithDictionary:(NSDictionary*)data;

-(NSString*)imageAddressWithType:(ImageType)type;

+(instancetype)movieWithDictionary:(NSDictionary*)data;
@end
