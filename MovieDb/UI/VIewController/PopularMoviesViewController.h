//
//  ViewController.h
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDMFetchedResultsTableDataSource.h"

@interface PopularMoviesViewController : UITableViewController <UITabBarControllerDelegate, MDMFetchedResultsTableDataSourceDelegate>


@end

