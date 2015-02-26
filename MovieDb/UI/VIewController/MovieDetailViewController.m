//
//  MovieDetailViewController.m
//  MovieDb
//
//  Created by Saqib Saud on 14/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import "MovieDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;
@property (weak, nonatomic) IBOutlet UILabel *moviePopularity;
@property (weak, nonatomic) IBOutlet UILabel *movieGenre;

@property (nonatomic, retain) CDMovie * selectedMovie;

- (void) updateUI;
- (void) requestMovieDetails;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self updateUI];
    [self requestMovieDetails];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) requestMovieDetails{
    [CDMovie movieDetailsWithMovieId:self.selectedMovie.movieid block:^(NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{//Update the UI on main thread
                [self updateUI];
            });
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show ];
        }
    }];
}

- (void) updateUI{

    [self.moviePoster setImageWithURL:[self.selectedMovie moviePosterUrl]];
    self.title = self.selectedMovie.name;
    self.movieName.text = [NSString stringWithFormat:@"Name: %@", self.selectedMovie.name];
    self.movieYear.text = [NSString stringWithFormat:@"Year: %@", [self.selectedMovie yearString]];
    self.moviePopularity.text = [NSString stringWithFormat:@"Popularity: %.1f", [self.selectedMovie.popularity floatValue]];
    if (self.selectedMovie.category != nil) {
        self.movieGenre.text = [NSString stringWithFormat:@"Genre: %@", self.selectedMovie.category];
    }
}
- (void) setMovieDetails:(CDMovie*) movie{
    self.selectedMovie = movie;
}
@end
