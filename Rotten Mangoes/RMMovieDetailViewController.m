//
//  RMMovieDetailViewController.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-15.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMMovieDetailViewController.h"

@interface RMMovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;

@end

@implementation RMMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.reviewsButton.layer.cornerRadius = self.reviewsButton.frame.size.width/2.0f;
    self.reviewsButton.layer.masksToBounds = YES;
    self.reviewsButton.transform = CGAffineTransformMakeRotation(-M_PI_4);
    self.reviewsButton.transform = CGAffineTransformScale(self.reviewsButton.transform, 0.75, 0.75);
    
    if (self.movie){
        self.titleLabel.text = self.movie.title;
        self.castLabel.text = [NSString stringWithFormat:@"Starring: %@",
                               [self.movie.actorNames componentsJoinedByString:@", "]];
        self.synopsisLabel.text = self.movie.synopsis;
        self.movieImageView.image = nil;
    }
}



@end
