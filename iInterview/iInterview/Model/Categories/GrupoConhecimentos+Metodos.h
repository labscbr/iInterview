//
//  GrupoConhecimentos+Metodos.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "GrupoConhecimentos.h"

@interface GrupoConhecimentos (Metodos)

+ (GrupoConhecimentos *)adicionarGrupoConhecimento:(NSString *)parStrGrupoConhecimento;

+ (GrupoConhecimentos *)buscarGrupoConhecimento:(NSString *)parStrGrupoConhecimento;

+ (BOOL)apagarGrupoConhecimento:(NSString *)parStrGrupoConhecimento;

+ (NSArray *)buscarArrayTodosGrupoConhecimentos;

+ (NSFetchedResultsController *)buscarTodosGruposConhecimentos;

@end
