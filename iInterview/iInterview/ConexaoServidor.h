//
//  TSConexaoServidor.h
//  KoletoreS
//
//  Created by Wagner Lino on 24/10/13.
//  Copyright (c) 2013 TheSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConexaoServidor : NSObject

+ (ConexaoServidor *)sharedManager;

- (NSArray *)conectarEndereco:(NSString *)endereco;

@end
