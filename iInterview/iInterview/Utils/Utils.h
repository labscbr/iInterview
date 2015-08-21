//
//  Utils.h
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Utils : NSObject

- (BOOL)validarEmail:(NSString*)parEmail;
- (void)mostrarAlerta:(NSString *)parMensagem;
- (UIView *)gerarGrafico:(CGRect)parFrame comMedia:(float)parMedia;
- (UIView *)aplicarSombra:(UIView *)view;

+ (Utils *)shared;

@end
