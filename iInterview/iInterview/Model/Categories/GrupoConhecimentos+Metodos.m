//
//  GrupoConhecimentos+Metodos.m
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "GrupoConhecimentos+Metodos.h"
#import "Candidatos+Metodos.h"
#import "CandidatoConhecimento+Metodos.m"
#import "CoreDataManager.h"

@implementation GrupoConhecimentos (Metodos)

+ (GrupoConhecimentos *)adicionarGrupoConhecimento:(NSString *)parStrGrupoConhecimento
{
    if ([GrupoConhecimentos buscarGrupoConhecimento:parStrGrupoConhecimento] == FALSE) {
        GrupoConhecimentos *grupoConhecimento = (GrupoConhecimentos *)[[CoreDataManager sharedManager] createObject:@"GrupoConhecimentos"];

        grupoConhecimento.strGrupoConhecimento = parStrGrupoConhecimento;

        [[CoreDataManager sharedManager] saveContext];
        
        return grupoConhecimento;
    } else {
        NSLog(@"Erro ao adiciona objeto");
        return nil;
    }
}

+ (GrupoConhecimentos *)buscarGrupoConhecimento:(NSString *)parStrGrupoConhecimento
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"GrupoConhecimentos"];
    request.predicate = [NSPredicate predicateWithFormat:@"strGrupoConhecimento = %@", parStrGrupoConhecimento];
    
    NSError *error = nil;
    GrupoConhecimentos *grupoConhecimento = [[[[CoreDataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error] lastObject];
    return grupoConhecimento;
}

+ (BOOL)apagarGrupoConhecimento:(NSString *)parStrGrupoConhecimento
{
    GrupoConhecimentos *grupoConhecimentos = [GrupoConhecimentos buscarGrupoConhecimento:parStrGrupoConhecimento];
    if (grupoConhecimentos == nil){
        return FALSE;
    }
    [[[CoreDataManager sharedManager] managedObjectContext] deleteObject:grupoConhecimentos];
    
    [[CoreDataManager sharedManager] saveContext];
    return TRUE;
}

+ (NSArray *)buscarArrayTodosGrupoConhecimentos
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"GrupoConhecimentos"];
    NSError *error = nil;
    NSArray *nsaResultado = [[[CoreDataManager sharedManager] managedObjectContext]
                             executeFetchRequest:request error:&error] ;
    return nsaResultado;
}

+ (NSFetchedResultsController *)buscarTodosGruposConhecimentos
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"GrupoConhecimentos"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"strGrupoConhecimento" ascending:YES];
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
