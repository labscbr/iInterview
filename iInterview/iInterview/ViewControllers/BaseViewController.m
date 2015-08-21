//
//  BaseViewController.m
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

# pragma mark -
# pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark -
# pragma mark CoreData Base

//- (void)loadData {
//    if (!self.standardPredicate || !self.standardSortDescriptors || !self.standardEntityName) {
//        NSLog(@"Não é possível executar o fetch sem um predicate, descriptor ou entity na tela %@", self.title);
//        return;
//    }
//    
//    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//    privateContext.persistentStoreCoordinator = [[TSCoreDataManager sharedManager] persistentStoreCoordinator];
//    
//    _fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self standardFetchRequest] managedObjectContext:privateContext sectionNameKeyPath:nil cacheName:nil];
//    [_fetchController performFetch:nil];
//    
//    [self didLoadData];
//}
//
//- (NSFetchRequest *)standardFetchRequest {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.standardEntityName];
//    fetchRequest.sortDescriptors = self.standardSortDescriptors;
//    NSPredicate *predicate = self.standardPredicate;
//    
//    fetchRequest.predicate = predicate;
//    return fetchRequest;
//}
//
//- (NSArray *)standardSortDescriptors {
//    return nil;
//}
//
//- (NSPredicate *)standardPredicate {
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"stInativo == 0"]];
//    return predicate;
//}
//
//- (NSString *)standardEntityName {
//    return nil;
//}
//
//- (void)didLoadData {
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}



@end
