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
@property (weak, nonatomic) IBOutlet UIView *reviewPagesContainer;

@end

@implementation RMMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.movie){
        self.titleLabel.text = self.movie.title;
        self.castLabel.text = [self.movie.actorNames componentsJoinedByString:@", "];
        self.synopsisLabel.text = self.movie.synopsis;
    }
}



@end
