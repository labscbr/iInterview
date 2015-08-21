//
//  CandidatoConhecimento+Metodos.m
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 20/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "CandidatoConhecimento+Metodos.h"
#import "Candidatos+Metodos.h"
#import "CoreDataManager.h"

@implementation CandidatoConhecimento (Metodos)

+ (CandidatoConhecimento *)adicionarCandidato:(Candidatos *)parCandidato comConhecimento:(Conhecimentos*)parConhecimento
{
    CandidatoConhecimento *candidatoConhecimento = [CandidatoConhecimento buscarCandidato:parCandidato
                                                                          comConhecimento:parConhecimento];
    if ( candidatoConhecimento == nil){
        candidatoConhecimento = (CandidatoConhecimento *)[[CoreDataManager sharedManager] createObject:@"CandidatoConhecimento"];
        candidatoConhecimento.candidato = parCandidato;
        candidatoConhecimento.conhecimento = parConhecimento;
        candidatoConhecimento.intPontuacao = 0;
    }
    return candidatoConhecimento;
}


+ (CandidatoConhecimento *)buscarCandidato:(Candidatos *)parCandidato comConhecimento:(Conhecimentos*)parConhecimento
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CandidatoConhecimento"];
    request.predicate = [NSPredicate predicateWithFormat:@"candidato = %@ and conhecimento = %@", parCandidato, parConhecimento];
    
    NSError *error = nil;
    CandidatoConhecimento *candidatoConhecimento = [[[[CoreDataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error] lastObject];
    return candidatoConhecimento;
}

+ (BOOL)apagarCandidato:(Candidatos *)parCandidato comConhecimento:(Conhecimentos*)parConhecimento
{
    CandidatoConhecimento *candidatoConhecimento = [CandidatoConhecimento buscarCandidato:parCandidato
                                                                          comConhecimento:parConhecimento];

    if (candidatoConhecimento == nil) {
        return FALSE;
    }
    
    [[[CoreDataManager sharedManager] managedObjectContext] deleteObject:candidatoConhecimento];
    
    [[CoreDataManager sharedManager] saveContext];
    return TRUE;
}

+ (NSArray *)buscarArrayTodosConhecimentosdoCandidato:(Candidatos *)parCandidato
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CandidatoConhecimento"];
    request.predicate = [NSPredicate predicateWithFormat:@"candidato = %@", parCandidato];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"conhecimento" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];

    NSError *error = nil;
    NSArray *nsaResultado = [[[CoreDataManager sharedManager] managedObjectContext]
                             executeFetchRequest:request error:&error] ;
    return nsaResultado;
}

+ (NSArray *)buscarArrayTodosConhecimentosdoCandidato:(Candidatos *)parCandidato doGrupoConhecimento:(GrupoConhecimentos *)parGrupoConhecimento
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CandidatoConhecimento"];
    request.predicate = [NSPredicate predicateWithFormat:@"candidato = %@ and conhecimento.grupoConhecimento = %@",
                         parCandidato, parGrupoConhecimento];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"conhecimento" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError *error = nil;
    NSArray *nsaResultado = [[[CoreDataManager sharedManager] managedObjectContext]
                             executeFetchRequest:request error:&error] ;
    return nsaResultado;
}

- (void)definirPontuacaoConhecimento:(int)parPontuacao
{
    self.intPontuacao = [NSNumber numberWithInt:parPontuacao];
    [[CoreDataManager sharedManager] saveContext];
}


@end
