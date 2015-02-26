//
//  MovieDetailViewController.h
//  MovieDb
//
//  Created by Saqib Saud on 14/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController
/**
 *  Set the movie of which we are going to show details.
 *
 *  @param movie CDmovie 
 */
- (void) setMovieDetails:(CDMovie*) movie;
@end
