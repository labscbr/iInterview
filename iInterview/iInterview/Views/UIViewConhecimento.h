//
//  ConhecimentoView.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 19/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conhecimentos+Metodos.h"
#import "GrupoConhecimentos+Metodos.h"
#import "DKCircularSlider.h"

@interface UIViewConhecimento : UIView

@property id delegate;
@property (strong, nonatomic) DKCircularSlider *dkCSlider;

@property CGPoint gestureStartPoint;

- (instancetype)initWithFrame:(CGRect)frame naPagina:(int)parPage comObjeto:(Conhecimentos *)parConhecimento;

@end
