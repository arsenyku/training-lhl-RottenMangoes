//
//  RMMovieCell.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMMovieCell.h"
#import "NSURL+DownloadFromAddress.h"

@interface RMMovieCell()
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (nonatomic) RMMovie *movie;
@property (nonatomic) UIImage *image;
@end

@implementation RMMovieCell


-(void)setContent:(RMMovie*)movie{
    _movie = movie;

    self.titleLabel.text = self.movie.title;
    self.ratingLabel.text = self.movie.mpaaRating;
    
    NSString* movieImageAddress = [self.movie imageAddressWithType:Thumbnail];
    [NSURL downloadFromAddress:movieImageAddress completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        UIImage *downloadedImage = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.collectionImageView.image = downloadedImage;
            
        });
        
        
    }];

    self.collectionImageView.image = self.image;
}

@end
