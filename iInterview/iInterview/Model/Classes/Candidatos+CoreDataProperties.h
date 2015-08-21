//
//  Candidatos+CoreDataProperties.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Candidatos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Candidatos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *strEmail;
@property (nullable, nonatomic, retain) NSString *strNome;
@property (nullable, nonatomic, retain) NSSet<CandidatoConhecimento *> *conhecimento;

@end

@interface Candidatos (CoreDataGeneratedAccessors)

- (void)addConhecimentoObject:(CandidatoConhecimento *)value;
- (void)removeConhecimentoObject:(CandidatoConhecimento *)value;
- (void)addConhecimento:(NSSet<CandidatoConhecimento *> *)values;
- (void)removeConhecimento:(NSSet<CandidatoConhecimento *> *)values;

@end

NS_ASSUME_NONNULL_END
