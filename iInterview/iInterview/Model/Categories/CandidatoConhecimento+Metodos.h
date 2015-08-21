//
//  CandidatoConhecimento+Metodos.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 20/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "CandidatoConhecimento.h"
#import "Conhecimentos+Metodos.h"

@interface CandidatoConhecimento (Metodos)

+ (CandidatoConhecimento *)adicionarCandidato:(Candidatos *)parCandidatoConhecimento comConhecimento:(Conhecimentos*)parConhecimento;

+ (CandidatoConhecimento *)buscarCandidato:(Candidatos *)parCandidatoConhecimento comConhecimento:(Conhecimentos*)parConhecimento;

+ (BOOL)apagarCandidato:(Candidatos *)parCandidato comConhecimento:(Conhecimentos*)parConhecimento;

- (void)definirPontuacaoConhecimento:(int)parPontuacao;

+ (NSArray *)buscarArrayTodosConhecimentosdoCandidato:(Candidatos *)parCandidato;

+ (NSArray *)buscarArrayTodosConhecimentosdoCandidato:(Candidatos *)parCandidato doGrupoConhecimento:(GrupoConhecimentos *)parGrupoConhecimento;


@end
