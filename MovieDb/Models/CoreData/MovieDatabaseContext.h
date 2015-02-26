//
//  MovieDatabaseContext.h
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDatabaseContext : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *writerManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 *  Coredata singleton for managing operations
 *
 *  @return shared instance
 */
+ (MovieDatabaseContext *) sharedContext;

/**
 *  Save context to file for persistance
 */
- (void)saveContext;

/**
 *
 *
 *  @return Path to the application directory
 */
- (NSURL *)applicationDocumentsDirectory;
@end
