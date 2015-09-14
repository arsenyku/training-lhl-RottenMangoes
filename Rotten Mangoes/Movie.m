//
//  Movie.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Movie.h"
#import "NSNumber+NumberFromString.h"

static NSString* const ImageKey_Thumbnail = @"thumbnail";
static NSString* const ImageKey_Original = @"original";
static NSString* const ImageKey_Profile = @"profile";
static NSString* const ImageKey_Detailed = @"detailed";

static NSString* const InTheatresKey_Id = @"id";
static NSString* const InTheatresKey_Title = @"title";
static NSString* const InTheatresKey_Year = @"year";
static NSString* const InTheatresKey_MpaaRating = @"mpaa_rating";
static NSString* const InTheatresKey_Runtime = @"runtime";
static NSString* const InTheatresKey_Synopsis = @"synopsis";
static NSString* const InTheatresKey_Images = @"posters";


@interface Movie()
@property(nonatomic, strong)NSString* identifier;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSNumber* year;
@property(nonatomic, strong)NSString* mpaaRating;
@property(nonatomic, strong)NSNumber* runtimeInMinutes;
@property(nonatomic, strong)NSString* synopsis;
@property(nonatomic, strong)NSDictionary* images;

@end

@implementation Movie
-(instancetype)initWithDictionary:(NSDictionary*)movieData{
    self = [super init];
    if (self) {
        _identifier = movieData[ InTheatresKey_Id ];
        _title = movieData[ InTheatresKey_Title ];
        _year = [NSNumber numberFromString: movieData[ InTheatresKey_Year ]];
        _mpaaRating = movieData[ InTheatresKey_MpaaRating ];
        _runtimeInMinutes = [NSNumber numberFromString: movieData[ InTheatresKey_Runtime ]];
        _synopsis = movieData[ InTheatresKey_Synopsis ];
        _images = movieData[ InTheatresKey_Images ];
    }
    return self;
}




-(UIImage *)imageWithType:(ImageType)type{
	if (self.images == nil)
        return nil;
    
    NSString *key = ImageKey_Original;
    switch (type) {
        case Detailed:
            key = ImageKey_Detailed;
            break;
            
        case Profile:
            key = ImageKey_Profile;
            break;
            
        case Thumbnail:
            key = ImageKey_Thumbnail;
            break;

        default:
            break;
    }
    
    return self.images[ key ];
}
@end
