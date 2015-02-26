// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDMovie.h instead.

#import <CoreData/CoreData.h>

extern const struct CDMovieAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *movieid;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *page;
	__unsafe_unretained NSString *popularity;
	__unsafe_unretained NSString *thumbnail;
	__unsafe_unretained NSString *timeStamp;
} CDMovieAttributes;

@interface CDMovieID : NSManagedObjectID {}
@end

@interface _CDMovie : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDMovieID* objectID;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* movieid;

@property (atomic) int64_t movieidValue;
- (int64_t)movieidValue;
- (void)setMovieidValue:(int64_t)value_;

//- (BOOL)validateMovieid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* page;

@property (atomic) int16_t pageValue;
- (int16_t)pageValue;
- (void)setPageValue:(int16_t)value_;

//- (BOOL)validatePage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* popularity;

@property (atomic) float popularityValue;
- (float)popularityValue;
- (void)setPopularityValue:(float)value_;

//- (BOOL)validatePopularity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* thumbnail;

//- (BOOL)validateThumbnail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* timeStamp;

//- (BOOL)validateTimeStamp:(id*)value_ error:(NSError**)error_;

@end

@interface _CDMovie (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSNumber*)primitiveMovieid;
- (void)setPrimitiveMovieid:(NSNumber*)value;

- (int64_t)primitiveMovieidValue;
- (void)setPrimitiveMovieidValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePage;
- (void)setPrimitivePage:(NSNumber*)value;

- (int16_t)primitivePageValue;
- (void)setPrimitivePageValue:(int16_t)value_;

- (NSNumber*)primitivePopularity;
- (void)setPrimitivePopularity:(NSNumber*)value;

- (float)primitivePopularityValue;
- (void)setPrimitivePopularityValue:(float)value_;

- (NSString*)primitiveThumbnail;
- (void)setPrimitiveThumbnail:(NSString*)value;

- (NSDate*)primitiveTimeStamp;
- (void)setPrimitiveTimeStamp:(NSDate*)value;

@end
