//
//  MovieDatabaseContext.m
//  MovieDb
//
//  Created by Saqib Saud on 13/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import "MovieDatabaseContext.h"

@implementation MovieDatabaseContext
@synthesize persistenceController = _persistenceController;

#pragma mark -
#pragma mark ARC Singleton Implementation
static MovieDatabaseContext *sharedDatabaseContext = nil;
+ (MovieDatabaseContext *) sharedContext
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDatabaseContext = [[MovieDatabaseContext alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedDatabaseContext;
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.wisesabre.MovieDb" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Persistence Controller

- (MDMPersistenceController *)persistenceController {
    
    if (_persistenceController == nil) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MovieDb" withExtension:@"momd"];
        
#ifdef USE_IN_MEMORY_STORE
        _persistenceController = [[MDMPersistenceController alloc] initInMemoryTypeWithModelURL:modelURL];
#else
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MovieDb.sqlite"];
        _persistenceController = [[MDMPersistenceController alloc] initWithStoreURL:storeURL modelURL:modelURL];
#endif
        
        if (_persistenceController == nil) {
            
            NSLog(@"ERROR: Persistence controller could not be created");

        }
    }
    
    return _persistenceController;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    [self.persistenceController saveContextAndWait:NO completion:^(NSError *error) {
        if (error) {
            NSLog(@"ERROR: Data could not be saved %@", [error localizedDescription]);
        }
    }];
}



@end
