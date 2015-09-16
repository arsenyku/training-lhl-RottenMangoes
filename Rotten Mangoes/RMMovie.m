//
//  Movie.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMMovie.h"
#import "NSURLSession+DownloadFromAddress.h"


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
static NSString* const InTheatresKey_Cast = @"abridged_cast";

static NSString* const CastKey_Name = @"name";

static NSString* const HighResImageUrl = @"dkpu1ddg7pbsk.cloudfront.net";

@interface RMMovie()
@property(nonatomic, strong)NSString* identifier;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSNumber* year;
@property(nonatomic, strong)NSString* mpaaRating;
@property(nonatomic, strong)NSNumber* runtimeInMinutes;
@property(nonatomic, strong)NSString* synopsis;
@property(nonatomic, strong)NSDictionary* imageAddresses;
@property(nonatomic, strong)NSDictionary* cast;
@property(nonatomic, strong)NSMutableDictionary* imagesByImageType;

@property(nonatomic, strong)NSURLSessionTask *downloadTask;
@end
@implementation RMMovie
-(instancetype)initWithDictionary:(NSDictionary*)movieData{
    self = [super init];
    if (self) {
        _identifier = movieData[ InTheatresKey_Id ];
        _title = movieData[ InTheatresKey_Title ];
        _year = movieData[ InTheatresKey_Year ];
        _mpaaRating = movieData[ InTheatresKey_MpaaRating ];
        _runtimeInMinutes = movieData[ InTheatresKey_Runtime ];
        _synopsis = movieData[ InTheatresKey_Synopsis ];
        _imageAddresses = movieData[ InTheatresKey_Images ];
        _cast = movieData[ InTheatresKey_Cast ];
        _imagesByImageType = [NSMutableDictionary new];
    }
    return self;
}


-(NSArray*)actorNames{
    NSMutableArray *result = [NSMutableArray new];
    for (NSDictionary* actorInfo in self.cast) {
        NSString *actorName = actorInfo[ CastKey_Name ];
        [result addObject:actorName];
    }
    return [result copy];
}

-(UIImage*)imageWithType:(ImageType)type{
    return self.imagesByImageType[ [NSNumber numberWithInt:type ] ];
}


-(void)downloadImageWithType:(ImageType)type
                  completion:(void (^)(UIImage *, NSError *))completionHandler{

    NSString* movieImageAddress = [self imageAddressWithType:Original];
    
    if (self.downloadTask){
        [self.downloadTask suspend];
        [self.downloadTask cancel];
    }
    
    self.downloadTask = [NSURLSession downloadFromAddress:movieImageAddress
                                               completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   
                                                   
                                                   NSString *expectedURL = [self imageAddressWithType:Original];
                                                   
                                                   if (! [response.URL.absoluteString isEqualToString:expectedURL]){
                                                       NSLog(@"Discarding stale data from %@", response.URL.absoluteString);
                                                       return ;
                                                   }
                                                   
                                                   
                                                   if (error)
                                                       NSLog(@"Error while downloading image: %@", error);
                                                   
                                                   if (error.code == NSURLErrorCancelled)
                                                       return;
                                                   
                                                   UIImage *downloadedImage = [UIImage imageWithData:data];
                                                   
                                                   self.imagesByImageType[ [NSNumber numberWithInt:type] ] = downloadedImage;
                                                   
                                                   completionHandler(downloadedImage, error);
                                                   
                                               }
                         ];
    
}

-(NSString *)imageAddressWithType:(ImageType)type{
	if (self.imageAddresses == nil)
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
    
    NSString *result = self.imageAddresses[ key ];
    NSRange range = [result rangeOfString:HighResImageUrl];
	
    if (range.location < NSNotFound)
	    result = [NSString stringWithFormat:@"https://%@", [result substringFromIndex:range.location]];
    else
	    NSLog(@"Unexpected URL for image %@", result);
    
    return result;
}


+(instancetype)movieWithDictionary:(NSDictionary *)data{
    return [[RMMovie alloc] initWithDictionary:data];
}
@end
