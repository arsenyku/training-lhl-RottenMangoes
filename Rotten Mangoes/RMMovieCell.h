//
//  RMMovieCell.h
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMovie.h"

@interface RMMovieCell : UICollectionViewCell
-(void)setContent:(RMMovie*)movie;
-(void)setContentImage:(UIImage*)image;
@end
