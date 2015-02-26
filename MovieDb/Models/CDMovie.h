#import "_CDMovie.h"

@interface CDMovie : _CDMovie {}
/**
 *  Fills the object with values in dictionary
 *
 *  @param attributes API retured dictionary of parameters
 */
- (void) updateValueWithAttibuted:(NSDictionary *) attributes;

/**
 *  Thumbnail URL for poster image, generated using API 'configuration'
 *
 *  @return thumbnail url 45x45
 */
- (NSURL *) thumbNailUrl;
/**
 *  Returns the poster URL using the configuration API
 *
 *  @return poster 300x300 image
 */
- (NSURL *) moviePosterUrl;

/**
 *  Returns the date of movie
 *
 *  @return movie date
 */
- (NSString *) yearString;

/**
 *  Insert into manage context, with attributes
 *
 *  @param moc_       ManagedObjectContext
 *  @param attributes dictionary of parameters
 *
 *  @return instance of CDMovie
 */
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ withAttributes:(NSDictionary *)attributes;
/**
 *  Search of movie based on MovieId
 *
 *  @param movieId  movie Id of movie
 *  @param context_ managed Object context
 *
 *  @return returns the object if it exists in the given context, nil otherwise
 */
+ (id)movieWithId:(NSInteger)movieId withContext:(NSManagedObjectContext *)context_;
/**
 *  Request for popular movies
 *
 *  @param page  page name (page name can be 1-1000)
 *  @param block
 *
 *  @return initiated the popular movies request
 */
+ (NSURLSessionDataTask *)popularMoviesWithPage:(NSNumber *) page block:(void (^)(NSError *error))block;
/**
 *  fetches details of given movie
 *
 *  @param movieId
 *  @param block
 *
 *  @return 
 */
+ (NSURLSessionDataTask *)movieDetailsWithMovieId:(NSNumber *) movieId block:(void (^)(NSError *error))block ;
@end
