// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDMovie.m instead.

#import "_CDMovie.h"

const struct CDMovieAttributes CDMovieAttributes = {
	.category = @"category",
	.movieid = @"movieid",
	.name = @"name",
	.page = @"page",
	.popularity = @"popularity",
	.thumbnail = @"thumbnail",
	.timeStamp = @"timeStamp",
};

@implementation CDMovieID
@end

@implementation _CDMovie

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Movie";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Movie" inManagedObjectContext:moc_];
}

- (CDMovieID*)objectID {
	return (CDMovieID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"movieidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"movieid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"page"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"popularityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"popularity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic category;

@dynamic movieid;

- (int64_t)movieidValue {
	NSNumber *result = [self movieid];
	return [result longLongValue];
}

- (void)setMovieidValue:(int64_t)value_ {
	[self setMovieid:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveMovieidValue {
	NSNumber *result = [self primitiveMovieid];
	return [result longLongValue];
}

- (void)setPrimitiveMovieidValue:(int64_t)value_ {
	[self setPrimitiveMovieid:[NSNumber numberWithLongLong:value_]];
}

@dynamic name;

@dynamic page;

- (int16_t)pageValue {
	NSNumber *result = [self page];
	return [result shortValue];
}

- (void)setPageValue:(int16_t)value_ {
	[self setPage:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePageValue {
	NSNumber *result = [self primitivePage];
	return [result shortValue];
}

- (void)setPrimitivePageValue:(int16_t)value_ {
	[self setPrimitivePage:[NSNumber numberWithShort:value_]];
}

@dynamic popularity;

- (float)popularityValue {
	NSNumber *result = [self popularity];
	return [result floatValue];
}

- (void)setPopularityValue:(float)value_ {
	[self setPopularity:[NSNumber numberWithFloat:value_]];
}

- (float)primitivePopularityValue {
	NSNumber *result = [self primitivePopularity];
	return [result floatValue];
}

- (void)setPrimitivePopularityValue:(float)value_ {
	[self setPrimitivePopularity:[NSNumber numberWithFloat:value_]];
}

@dynamic thumbnail;

@dynamic timeStamp;

@end

