//
//  TSConexaoServidor.m
//  KoletoreS
//
//  Created by Wagner Lino on 24/10/13.
//  Copyright (c) 2013 TheSoft. All rights reserved.
//

#import "ConexaoServidor.h"

@implementation ConexaoServidor

+ (ConexaoServidor *)sharedManager {
    static dispatch_once_t onceToken;
    static ConexaoServidor *sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ConexaoServidor alloc] init];
    });
    
    return sharedInstance;
}

- (NSArray *)conectarEndereco:(NSString *)endereco{
    endereco = [endereco stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:endereco];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:120.0];
    
    NSError *error;

    NSData *retorno = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error ];
    
    NSString* myString;
    myString = [[NSString alloc] initWithData:retorno encoding:NSASCIIStringEncoding];
//    NSLog(@"%@", myString);
    
    NSArray *arrRetorno;
    if (!error)
        arrRetorno = [NSJSONSerialization JSONObjectWithData:retorno options:NSJSONReadingAllowFragments error:nil];
    else
        arrRetorno = nil;
    
    return arrRetorno;

}

@end
