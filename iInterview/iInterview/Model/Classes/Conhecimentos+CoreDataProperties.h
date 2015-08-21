//
//  Conhecimentos+CoreDataProperties.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Conhecimentos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Conhecimentos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *strConhecimento;
@property (nullable, nonatomic, retain) NSSet<CandidatoConhecimento *> *candidato;
@property (nullable, nonatomic, retain) GrupoConhecimentos *grupoConhecimento;

@end

@interface Conhecimentos (CoreDataGeneratedAccessors)

- (void)addCandidatoObject:(CandidatoConhecimento *)value;
- (void)removeCandidatoObject:(CandidatoConhecimento *)value;
- (void)addCandidato:(NSSet<CandidatoConhecimento *> *)values;
- (void)removeCandidato:(NSSet<CandidatoConhecimento *> *)values;

@end

NS_ASSUME_NONNULL_END
