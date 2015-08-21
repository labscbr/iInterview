//
//  CoreDataManager.h
//  iInterview
//
//  Created by Luciano A. Baramarchi on 17/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataManager *)sharedManager;
- (void)saveContext;
- (NSManagedObject *)createObject:(NSString *)parString;

@end
