//
//  Conhecimentos+Metodos.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "Conhecimentos.h"

@interface Conhecimentos (Metodos)

+ (Conhecimentos *)adicionarConhecimento:(NSString *)parStrConhecimento;

+ (Conhecimentos *)buscarConhecimento:(NSString *)parStrConhecimento;

+ (BOOL)apagarConhecimento:(NSString *)parStrConhecimento;

+ (NSArray *)buscarArrayTodosConhecimentos;

+ (NSFetchedResultsController *)buscarTodosConhecimentos;

@end
