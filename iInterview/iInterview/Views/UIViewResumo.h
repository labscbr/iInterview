//
//  UIViewResumo.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 20/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Candidatos+Metodos.h"

@interface UIViewResumo : UIView

@property id delegate;
@property (strong, nonatomic) Candidatos *candidatoAtual;

@property (assign) int intResultado;

- (void)apresentarResumo;

@end
