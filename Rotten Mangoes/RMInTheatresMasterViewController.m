//
//  ViewController.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMInTheatresMasterViewController.h"
#import "RMMovie.h"
#import "RMMovieCell.h"
#import "NSURLSession+DownloadFromAddress.h"

static NSString* const API_KEY = @"j9fhnct2tp8wu2q9h75kanh9";
static NSString* const InTheatresKey_Movies = @"movies";

@interface RMInTheatresMasterViewController () <UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *moviesInTheatres;
@end

@implementation RMInTheatresMasterViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _moviesInTheatres = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self loadInitialData];
    
}



#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.moviesInTheatres count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    RMMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell"
                                                                  forIndexPath:indexPath] ;

    [cell setContent:self.moviesInTheatres[ indexPath.item ] ];

    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark - private

-(void)loadInitialData{
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=50";
    NSString *urlStringWithApiKey = [NSString stringWithFormat:urlString, API_KEY];
    
    [NSURLSession downloadFromAddress:urlStringWithApiKey completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error){
            NSLog(@"In Theatres Endpoint Download Error: %@", error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *inTheatres = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonError){
            NSLog(@"In Theatres Endpoint Deserialization Error: %@", error);
            return;
        }
        
        NSArray *movies = inTheatres[ InTheatresKey_Movies ];
        
        for (NSDictionary *movieData in movies) {
            [self.moviesInTheatres addObject:[RMMovie movieWithDictionary:movieData]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.collectionView reloadData];
        });

        
    }];

}
@end
