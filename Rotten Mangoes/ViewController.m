//
//  ViewController.m
//  Rotten Mangoes
//
//  Created by asu on 2015-09-14.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static NSString* const API_KEY = @"j9fhnct2tp8wu2q9h75kanh9";
static NSString* const InTheatresKey_Movies = @"movies";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=%@&page_limit=50";
    NSString *urlStringWithApiKey = [NSString stringWithFormat:urlString, API_KEY];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlStringWithApiKey]
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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
//                                                statements
                                            }
                                            
                                            
//                                            NSLog(@"%@", inTheatres);
                                            
//                                            dispatch_async(dispatch_get_main_queue(), ^{
//                                                
//                                                [self.tableView reloadData];
//                                                
//                                            });
                                        }];
    
    [dataTask resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
