//
//  MovieDatabaseContext.h
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MDMCoreData/MDMPersistenceController.h>

@interface MovieDatabaseContext : NSObject
@property (nonatomic, strong) MDMPersistenceController *persistenceController;



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
