//
//  RMMovieCell.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMMovieCell.h"
#import "NSURLSession+DownloadFromAddress.h"

@interface RMMovieCell()
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (nonatomic) RMMovie *movie;

@property (nonatomic) NSURLSessionTask *downloadTask;

@end

@implementation RMMovieCell


-(void)setRatingLabel:(UILabel *)ratingLabel{
    _ratingLabel = ratingLabel;
    
    _ratingLabel.layer.cornerRadius = 10.0f;
    _ratingLabel.layer.masksToBounds = YES;
}

    
-(void)setContent:(RMMovie*)movie{
    _movie = movie;

    self.titleLabel.text = self.movie.title;
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", self.movie.mpaaRating];
    self.collectionImageView.image = nil;

    [self downloadMovieImage];
}


-(void)downloadMovieImage{
    
    NSString* movieImageAddress = [self.movie imageAddressWithType:Original];
 
    if (self.downloadTask){
        [self.downloadTask suspend];
        [self.downloadTask cancel];
    }
    
    self.downloadTask = [NSURLSession downloadFromAddress:movieImageAddress
                                               completion:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   
                                                   
                                                   NSString *expectedURL = [self.movie imageAddressWithType:Original];
                                                   
                                                   if (! [response.URL.absoluteString isEqualToString:expectedURL]){
                                                       NSLog(@"Discarding stale data from %@", response.URL.absoluteString);
                                                       return ;
                                                   }
                                                   
                                                   
                                                   if (error)
                                                       NSLog(@"Error while downloading image: %@", error);
                                                   
                                                   if (error.code == NSURLErrorCancelled)
                                                       return;
                                                   
                                                   UIImage *downloadedImage = [UIImage imageWithData:data];
                                                   
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       
                                                       self.collectionImageView.image = downloadedImage;
                                                       
                                                   });
                                                   
                                                   
                                               }
                         ];
    

}
@end
