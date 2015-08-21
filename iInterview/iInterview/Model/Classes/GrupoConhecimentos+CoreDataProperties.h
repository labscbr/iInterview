//
//  GrupoConhecimentos+CoreDataProperties.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "GrupoConhecimentos.h"

NS_ASSUME_NONNULL_BEGIN

@interface GrupoConhecimentos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *strGrupoConhecimento;
@property (nullable, nonatomic, retain) NSSet<Conhecimentos *> *conhecimento;

@end

@interface GrupoConhecimentos (CoreDataGeneratedAccessors)

- (void)addConhecimentoObject:(Conhecimentos *)value;
- (void)removeConhecimentoObject:(Conhecimentos *)value;
- (void)addConhecimento:(NSSet<Conhecimentos *> *)values;
- (void)removeConhecimento:(NSSet<Conhecimentos *> *)values;

@end

NS_ASSUME_NONNULL_END
