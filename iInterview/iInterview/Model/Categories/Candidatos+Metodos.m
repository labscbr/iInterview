//
//  Candidatos+Metodos.m
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "Candidatos+Metodos.h"
#import "CandidatoConhecimento+Metodos.h"
#import "CoreDataManager.h"
#import "Utils.h"

@implementation Candidatos (Metodos)

+ (Candidatos *)adicionarCandidato:(NSString *)parStrNome comEmail:(NSString *)parStrEmail {

    Candidatos *candidato = [Candidatos buscarCandidato:parStrEmail];
    if ( candidato == nil) {
        candidato = (Candidatos *)[[CoreDataManager sharedManager] createObject:@"Candidatos"];
    }
    
    candidato.strEmail = parStrEmail;
    candidato.strNome  = parStrNome;
        
    [[CoreDataManager sharedManager] saveContext];
        
    return candidato;
}

+ (BOOL)apagarCandidato:(NSString *)parStrEmail {
    Candidatos *candidato = [Candidatos buscarCandidato:parStrEmail];
    if (candidato == nil) {
        return FALSE;
    }
    
    [candidato apagarConhecimentosCandidato ];

    [[[CoreDataManager sharedManager] managedObjectContext] deleteObject:candidato];

    [[CoreDataManager sharedManager] saveContext];
    return TRUE;
}

+ (Candidatos *)buscarCandidato:(NSString *)parStrEmail {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Candidatos"];
    request.predicate = [NSPredicate predicateWithFormat:@"strEmail = %@", parStrEmail];

    NSError *error = nil;
    Candidatos *candidato = [[[[CoreDataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error] lastObject];
    return candidato;
}


+ (NSFetchedResultsController *)buscarTodosCandidatos {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Candidatos"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"strNome" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    [request setFetchBatchSize:20];
    [[[CoreDataManager sharedManager] managedObjectContext]
     executeFetchRequest:request error:nil];
    
    NSFetchedResultsController *frcResultado =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:@"root"];
    
    NSError *error;
    [frcResultado performFetch:&error];
    return frcResultado;
}

- (float)calcularPontuacaoMedia:(GrupoConhecimentos *)parGrupoConhecimento
{
    NSArray *nsaCandidatoConecimentos = [CandidatoConhecimento buscarArrayTodosConhecimentosdoCandidato:self doGrupoConhecimento:parGrupoConhecimento];
    float fltMedia = 0;
    for (int i = 0; i < nsaCandidatoConecimentos.count; i++){
        CandidatoConhecimento *candidatoConhecimentoAtual = [nsaCandidatoConecimentos objectAtIndex:i];
        fltMedia += [candidatoConhecimentoAtual.intPontuacao floatValue];
    }
    
    fltMedia = fltMedia / (nsaCandidatoConecimentos.count);
    return fltMedia;
}

- (void)apagarConhecimentosCandidato
{
    NSArray *conhecimentos = [CandidatoConhecimento buscarArrayTodosConhecimentosdoCandidato:self];
    if (conhecimentos.count > 0){
        for (int i = 0; i < conhecimentos.count; i++){
            CandidatoConhecimento *candidatoConhecimento = [conhecimentos objectAtIndex:i];
            [CandidatoConhecimento apagarCandidato:self comConhecimento:candidatoConhecimento.conhecimento];
        }
    }
}

@end
