//
//  Candidatos+Metodos.h
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "Candidatos.h"
#import "GrupoConhecimentos+Metodos.h"

@interface Candidatos (Metodos)

+ (Candidatos *)adicionarCandidato:(NSString *)parStrNome comEmail:(NSString *)parStrEmail;

+ (Candidatos *)buscarCandidato:(NSString *)parStrEmail;

+ (BOOL)apagarCandidato:(NSString *)parStrEmail;

+ (NSFetchedResultsController *)buscarTodosCandidatos;

- (float)calcularPontuacaoMedia:(GrupoConhecimentos *)parGrupoConhecimento;

@end
