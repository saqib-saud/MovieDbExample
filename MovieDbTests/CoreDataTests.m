//
//  CoreDataTests.m
//  MovieDb
//
//  Created by Saqib Saud on 14/02/2015.
//  Copyright (c) 2015 Saqib Saud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface CoreDataTests : XCTestCase
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@end

@implementation CoreDataTests
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (void)setUp {
    [super setUp];
    [super setUp];
    // Create a managed object model from the test bundle.

    [self persistentStoreCoordinator];
}

- (void)tearDown {
    NSPersistentStore *store = nil;
    NSError *error = nil;
    store = [[self persistentStoreCoordinator] persistentStoreForURL:[self storeURL]];
    // Remove the store from the coordinator. If this fails that is fine.
    if (store != nil){
        [[self persistentStoreCoordinator] removePersistentStore:store error:&error];
    }
    // Note that in many cases, a test should also remove any file created at the storeURL location.
    // Doing so should work as follows:
    // [[NSFileManager defaultManager] removeItemAtURL:[self storeURL] error:&error];
    // Unregister the store
    if ([self storeClass] != nil){
        [[[self persistentStoreCoordinator] class] registerStoreClass:nil forStoreType:[self storeType]];
    }
    [super tearDown];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MovieDb" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self storeURL] URLByAppendingPathComponent:@"MovieDb.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        XCTFail(@"Could not add store, %@", error);

    }
    
    return _persistentStoreCoordinator;
}
- (Class )storeClass {
    // Only override if you are testing a custom store, such as an NSAtomicStore or NSIncrementalStore
    return nil;
}
- (NSDictionary *)storeOptions {
    return nil;
}


- (NSURL *)storeURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (NSString *)storeType {
    return NSSQLiteStoreType;
}

- (void)testFetchDoesNotThrowException {

    NSManagedObjectContext *context = nil;
    NSError *error = nil;
    NSPredicate *predicate = nil;
    NSEntityDescription *entity = nil;
    NSFetchRequest *fetchRequest = nil;
    // Note that in a production application you should not use NSConfinementConcurrencyType.
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    entity = [[[[context persistentStoreCoordinator] managedObjectModel] entities] lastObject];
    fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[entity name]];
    // A nil predicate will return everything.
    [fetchRequest setPredicate:predicate];
    // The objective for this test is to perform a fetch without throwing an exception.
    XCTAssertNoThrow([context executeFetchRequest:fetchRequest error:&error], @"Fetch threw exception.");
}

@end
