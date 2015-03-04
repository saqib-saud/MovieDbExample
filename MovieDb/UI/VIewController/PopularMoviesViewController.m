//
//  ViewController.m
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import "PopularMoviesViewController.h"
#import "MovieDbtableViewCell.h"
#import <AFNetworking/UIRefreshControl+AFNetworking.h>
#import "MovieDetailViewController.h"

@interface PopularMoviesViewController ()
@property (nonatomic, assign) int pageCounter;
@property (nonatomic,retain) NSFetchedResultsController *fetchController;
@property (nonatomic, strong) MDMFetchedResultsTableDataSource *collectionDataSource;


- (void) setup;
- (void) loadNextPage;
- (void) loadPreviousPage;
- (void) updateFetchPredicate;
- (IBAction) refreshData:(id)sender;
- (void)setupCollectionDataSource;

@end

@implementation PopularMoviesViewController
@synthesize fetchController= _fetchController;

#pragma mark - Initialization
- (void) setup{
    [self.tableView registerNib:[MovieDbTableViewCell nib] forCellReuseIdentifier:[MovieDbTableViewCell cellReuseIdentifier]];
    self.pageCounter = 1;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(loadPreviousPage)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(loadNextPage)];
    [self setupCollectionDataSource];
}


- (void)setupCollectionDataSource {
    
    self.collectionDataSource = [[MDMFetchedResultsTableDataSource alloc] initWithTableView:self.tableView
                                                                   fetchedResultsController:[self fetchController]];
    
    self.collectionDataSource.delegate = self;
    self.collectionDataSource.reuseIdentifier = [MovieDbTableViewCell cellReuseIdentifier];
    self.tableView.dataSource = self.collectionDataSource;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self refreshData:nil];
    self.title = [NSString stringWithFormat:@"Page:%i", self.pageCounter];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieDetailViewController * movieDetailVC = [segue destinationViewController];
    [movieDetailVC setMovieDetails:sender];
    
}

#pragma mark - MDMFetchedResultsCollectionDataSourceDelegate

- (void)dataSource:(MDMFetchedResultsTableDataSource *)dataSource configureCell:(id)cell withObject:(id)object{
    MovieDbTableViewCell *movieCell = (MovieDbTableViewCell *) cell;
    [movieCell setMovie:object];
}
- (void)dataSource:(MDMFetchedResultsTableDataSource *)dataSource deleteObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    //Delete anything if you want to
}


- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MovieDbTableViewCell heightForCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieDetailViewController" sender:[self.fetchController objectAtIndexPath:indexPath]];
}



#pragma mark - NSFetchedResultControllerMethods
-(NSFetchedResultsController*)fetchController
{
    if(_fetchController)
    {
        return _fetchController;
    }
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:[CDMovie entityName]];
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"%@",CDMovieAttributes.popularity] ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    request.predicate = [NSPredicate predicateWithFormat:@"%K = %i", CDMovieAttributes.page, self.pageCounter];
    _fetchController=[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[MovieDatabaseContext sharedContext].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error;
    if([_fetchController performFetch:&error])
    {
        NSLog(@"error description: %@",error);
    }
    return _fetchController;
}

- (void) updateFetchPredicate{
    NSFetchRequest *request = self.fetchController.fetchRequest ;
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:[NSString stringWithFormat:@"%@",CDMovieAttributes.popularity] ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    request.predicate = [NSPredicate predicateWithFormat:@"%K = %i", CDMovieAttributes.page, self.pageCounter];
    
    NSError *error;
    if(![_fetchController performFetch:&error])
    {
        NSLog(@"error description: %@",error);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        
    });
}


#pragma mark -

- (void) loadNextPage{
    if (self.pageCounter <= 1000){//API can support max 1000 pages
        self.pageCounter ++;
    }
    [self refreshData:nil];
}
- (void) loadPreviousPage{
    if (self.pageCounter > 1){
        self.pageCounter --;
    }
    [self refreshData:nil];
    
}

- (IBAction)refreshData:(id)sender{
    self.title = [NSString stringWithFormat:@"Page:%i", self.pageCounter];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionTask *task = [CDMovie popularMoviesWithPage:[NSNumber numberWithInt:self.pageCounter] block:^(NSError *error) {
        if (!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateFetchPredicate];
            });
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil]show ];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.leftBarButtonItem.enabled = YES;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
}


- (void) dealloc{
    self.fetchController.delegate= nil;
    self.fetchController = nil;
}
@end
