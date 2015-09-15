//
//  ViewController.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "RMInTheatresMasterViewController.h"
#import "RMMovieDetailViewController.h"
#import "RMMovie.h"
#import "RMMovieCell.h"
#import "NSURLSession+DownloadFromAddress.h"

static NSString* const API_KEY = @"j9fhnct2tp8wu2q9h75kanh9";
static NSString* const InTheatresKey_Movies = @"movies";
static NSString* const InTheatresKey_Total = @"total";

@interface RMInTheatresMasterViewController () <UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *moviesInTheatres;

@property(nonatomic)int moviesPerPage;
@property(nonatomic)int currentPage;
@property(nonatomic)int numberOfMoviesInTheatres;

@end

@implementation RMInTheatresMasterViewController


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _moviesInTheatres = [NSMutableArray new];
        _moviesPerPage = 50;
        _currentPage = 1;
        _numberOfMoviesInTheatres = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadData];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowMovieDetail"]){
        RMMovieDetailViewController *destination = segue.destinationViewController;
        
        destination.movie = sender;
    }
}


#pragma mark - <UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    RMMovie *movie = self.moviesInTheatres[indexPath.item];
    [self performSegueWithIdentifier:@"ShowMovieDetail" sender:movie];
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

    if (self.moviesPerPage * self.currentPage - 1 <= indexPath.item){
        [self loadMoreData];
    }
    
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


#pragma mark - private

-(void)loadData{
    
    [NSURLSession downloadFromAddress:self.urlStringWithApiKey completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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

        self.numberOfMoviesInTheatres = [(NSNumber *)inTheatres[ InTheatresKey_Total ] intValue];
        NSArray *movies = inTheatres[ InTheatresKey_Movies ];
        
        for (NSDictionary *movieData in movies) {
            [self.moviesInTheatres addObject:[RMMovie movieWithDictionary:movieData]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.collectionView reloadData];

        });

        
    }];

}

-(BOOL)moreMoviesAvailable{
    int downloadedSoFar = self.moviesPerPage * self.currentPage;
    return ( downloadedSoFar < self.numberOfMoviesInTheatres );
}

-(void)loadMoreData{
    
    if ( [self moreMoviesAvailable] ){
        self.currentPage += 1;
        [self loadData];
    }
}

-(NSString*)urlStringWithApiKey{
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=%d&page=%d";
    NSString *urlStringWithApiKey = [NSString stringWithFormat:urlString, API_KEY, self.moviesPerPage, self.currentPage];
    return urlStringWithApiKey;
}


@end
