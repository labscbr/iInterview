//
//  CandidatoConhecimento+CoreDataProperties.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "CandidatoConhecimento.h"

NS_ASSUME_NONNULL_BEGIN

@interface CandidatoConhecimento (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *intPontuacao;
@property (nullable, nonatomic, retain) Candidatos *candidato;
@property (nullable, nonatomic, retain) Conhecimentos *conhecimento;

@end

NS_ASSUME_NONNULL_END
