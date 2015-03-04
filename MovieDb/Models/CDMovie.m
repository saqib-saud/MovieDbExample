#import "CDMovie.h"
#import "AFMovieDbClient.h"
#import "MovieDatabaseContext.h"
@interface CDMovie ()

+ (void) parseMovieResponse:(NSArray *)moviesFromResponse page:(int)page block:(void (^)(NSError *error))block;
@end

@implementation CDMovie

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ withAttributes:(NSDictionary *)attributes{
    CDMovie * movie = [CDMovie insertInManagedObjectContext:moc_];
    [movie updateValueWithAttibuted:attributes];
    return movie;
}

- (void) updateValueWithAttibuted:(NSDictionary *) attributes{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        self.name = [attributes valueForKeyPath:@"title"];
        self.movieid = [attributes valueForKeyPath:@"id"];
        self.timeStamp = [formatter dateFromString: [attributes valueForKeyPath:@"release_date"]];
        self.popularity = [attributes valueForKeyPath:@"popularity"];
        if ([attributes valueForKeyPath:@"poster_path"] != [NSNull null]) {
            self.thumbnail = [attributes valueForKeyPath:@"poster_path"];
        }
        
        if ([attributes valueForKeyPath:@"genres"] != nil) {
            NSArray * genresArray = [attributes valueForKeyPath:@"genres"];
            for (int i=0; i <= [genresArray count]-1; i++) {
                NSDictionary * genresDictionary = [genresArray objectAtIndex:i];
                if (i == 0) {
                    self.category =  [genresDictionary valueForKeyPath:@"name"];
                }
                else {
                    self.category = [NSString stringWithFormat:@"%@, %@", self.category, [genresDictionary valueForKeyPath:@"name"]];
                }
                
                
            }
        }
        else{
            self.category = @" ";
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception:%@", [exception description]);
    }
}

+ (id)movieWithId:(NSInteger)movieId withContext:(NSManagedObjectContext *)context_
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K = %i ", CDMovieAttributes.movieid, movieId];
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:[CDMovie entityName]];
    request.predicate=predicate;
    NSError *error;
    NSArray *array=[context_ executeFetchRequest:request error:&error];
    if(!error && [array count] > 0)
    {
        return [array firstObject];
    }
    return nil;
}

#pragma mark - Network Calls

+ (NSURLSessionDataTask *)popularMoviesWithPage:(NSNumber *) page block:(void (^)(NSError *error))block {
    
    return [[AFMovieDbClient sharedInstance] GET:@"movie/popular" parameters:[@{@"page":page, @"sort_by": @"popularity.asc"}mutableCopy] success:^(NSURLSessionDataTask * __unused task, id JSON) {
        [self parseMovieResponse:[JSON valueForKeyPath:@"results"] page:[page intValue] block:block];
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}


+ (NSURLSessionDataTask *)movieDetailsWithMovieId:(NSNumber *) movieId block:(void (^)(NSError *error))block {
    
    return [[AFMovieDbClient sharedInstance] GET:[NSString stringWithFormat:@"movie/%i",[movieId integerValue]] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        [self parseMovieResponse:@[JSON] page:-1 block:block];

    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

#pragma mark - parsing
+ (void) parseMovieResponse:(NSArray *)moviesFromResponse page:(int)page block:(void (^)(NSError *error))block{
    if ([moviesFromResponse count] <= 0) {
        return;
    }
    // Creating managed objects
    __block NSManagedObjectContext *temporaryContext = [[[MovieDatabaseContext sharedContext] persistenceController] newPrivateChildManagedObjectContext];
    
    [temporaryContext performBlock:^{
        for (NSDictionary *attributes in moviesFromResponse) {
            NSInteger movieid = [[attributes valueForKeyPath:@"id"] integerValue];
            CDMovie * movie = [CDMovie movieWithId:movieid withContext:temporaryContext];
            if (!movie) {
                movie = [CDMovie insertInManagedObjectContext:temporaryContext withAttributes:attributes];
            }
            else{
                [movie updateValueWithAttibuted:attributes];
            }
            if (page > 0) {//positive page
                movie.pageValue = page;
            }
        }
        NSError *error = nil;
        if ([temporaryContext hasChanges] && (![temporaryContext save:&error])) {
            NSLog(@"Error in Saving MOC: %@",[error description]);
        }
        [[[MovieDatabaseContext sharedContext] persistenceController] saveContextAndWait:NO completion:nil];
    }]; // parent
}

- (NSURL *) thumbNailUrl{
    return [NSURL URLWithString:[NSString stringWithFormat:@"/t/p/w45/%@", self.thumbnail] relativeToURL:[NSURL URLWithString:kMovieImagesCDNBaseURL]];
}

- (NSURL *) moviePosterUrl{
    return [NSURL URLWithString:[NSString stringWithFormat:@"/t/p/w300/%@", self.thumbnail] relativeToURL:[NSURL URLWithString:kMovieImagesCDNBaseURL]];
}

- (NSString *) yearString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    return  [dateFormatter stringFromDate:self.timeStamp];
}
@end
