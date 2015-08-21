//
//  Conhecimentos+Metodos.m
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "Conhecimentos+Metodos.h"
#import "CoreDataManager.h"

@implementation Conhecimentos (Metodos)

+ (Conhecimentos *)adicionarConhecimento:(NSString *)parStrConhecimento
{

        Conhecimentos *conhecimento = (Conhecimentos *)[[CoreDataManager sharedManager] createObject:@"Conhecimentos"];
        
        conhecimento.strConhecimento = parStrConhecimento;
        
        [[CoreDataManager sharedManager] saveContext];
        
        return conhecimento;
}

+ (Conhecimentos *)buscarConhecimento:(NSString *)parStrConhecimento
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Conhecimentos"];
    request.predicate = [NSPredicate predicateWithFormat:@"strConhecimento = %@", parStrConhecimento];
    
    NSError *error = nil;
    Conhecimentos *conhecimento = [[[[CoreDataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error] lastObject];
    return conhecimento;
}

+ (BOOL)apagarConhecimento:(NSString *)parStrConhecimento
{
    Conhecimentos *conhecimento = [Conhecimentos buscarConhecimento:parStrConhecimento];
    if (conhecimento == nil) {
        return FALSE;
    }

    [[[CoreDataManager sharedManager] managedObjectContext] deleteObject:conhecimento];
    
    [[CoreDataManager sharedManager] saveContext];
    return TRUE;
}

+ (NSArray *)buscarArrayTodosConhecimentos
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Conhecimentos"];
    NSError *error = nil;
    NSArray *nsaResultado = [[[CoreDataManager sharedManager] managedObjectContext]
                             executeFetchRequest:request error:&error] ;
    return nsaResultado;
}

+ (NSFetchedResultsController *)buscarTodosConhecimentos
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Conhecimentos"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"strConhecimento" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setFetchBatchSize:20];
    [[[CoreDataManager sharedManager] managedObjectContext]
     executeFetchRequest:request error:nil];
    
    NSFetchedResultsController *frcResultado =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    NSError *error;
    [frcResultado performFetch:&error];
    return frcResultado;
}

@end
