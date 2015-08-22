//
//  ConhecimentoView.m
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 19/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "UIViewConhecimento.h"
#import "EntrevistaViewController.h"
#import "Utils.h"

#define COMPONENTRECT CGRectMake(45, 185, DK_SLIDER_SIZE-90, DK_SLIDER_SIZE-90)

@implementation UIViewConhecimento

- (instancetype)initWithFrame:(CGRect)frame naPagina:(int)parPage comObjeto:(Conhecimentos *)parConhecimento {
    self = [super initWithFrame:frame];

    self.tag=1002;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
//    UISwipeGestureRecognizer *swipeUPGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp)] ;
////    swipeUPGesture.numberOfTouchesRequired = 1;
//    swipeUPGesture.direction = UISwipeGestureRecognizerDirectionUp;
//    
//    [self addGestureRecognizer:swipeUPGesture];
//
//    UISwipeGestureRecognizer *swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown)] ;
////    swipeDownGesture.numberOfTouchesRequired = 1;
//    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
//    
//    [self addGestureRecognizer:swipeDownGesture];

    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    float intIndex = screenHeight/480;
    int intX = (screenWidth - 230) / 2 ;
    int intY = (screenHeight - 230) / 1.45 - 10 ;
    
    
    UIView *viewFundo = [[UIView alloc] initWithFrame:CGRectMake(21,
                                                                 65*intIndex,
                                                                 screenWidth - 42,
                                                                 360*intIndex)];
    viewFundo.backgroundColor = [UIColor whiteColor];
    
    viewFundo = [[Utils shared] aplicarSombra:viewFundo];
    
    [self addSubview:viewFundo];

    _dkCSlider = [[DKCircularSlider alloc] initWithFrame:CGRectMake(intX,
                                                                    intY,
                                                                    DK_SLIDER_SIZE-90,
                                                                    DK_SLIDER_SIZE-90)
                                                                 usingMax:10
                                                                 usingMin:0
                                                         withContentImage:nil
                                                                withTitle:nil
                                                               withTarget:self
                                                            usingSelector:@selector(sliderChange:)];
    _dkCSlider.currentValue = 10;
    _dkCSlider.lblTitulo.textColor = [UIColor blackColor];
    [_dkCSlider movehandleToValue:10];

    [self addSubview:_dkCSlider];

    UILabel *lblGrupoConhecimento = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                              30*intIndex,
                                                                              screenWidth - 40,
                                                                              40*intIndex)];
    lblGrupoConhecimento.text = [NSString stringWithFormat:@"%@ - %@", parConhecimento.grupoConhecimento.strGrupoConhecimento,
                                 parConhecimento.strConhecimento];
    lblGrupoConhecimento.textAlignment = NSTextAlignmentCenter;
    lblGrupoConhecimento.font = [UIFont boldSystemFontOfSize:18*intIndex];
    lblGrupoConhecimento.textColor = [UIColor whiteColor];
    lblGrupoConhecimento.backgroundColor = [UIColor darkGrayColor];
    lblGrupoConhecimento.minimumScaleFactor = 8.0f/14.0f;
    
    lblGrupoConhecimento.adjustsFontSizeToFitWidth = YES;
    lblGrupoConhecimento.numberOfLines = 0;
    
    [self addSubview:[[Utils shared] aplicarSombra:lblGrupoConhecimento]];
    
    UILabel *lblConhecimento = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                         65*intIndex,
                                                                         screenWidth - 40,
                                                                         80*intIndex)];
    lblConhecimento.text = @"Lembre-se:";
    lblConhecimento.textAlignment = NSTextAlignmentCenter;
    lblConhecimento.font = [UIFont boldSystemFontOfSize:18*intIndex];
    
    lblConhecimento.textColor = [UIColor blackColor];
    
    [self addSubview:lblConhecimento];
    
    UILabel *lblConhecimento2 = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                         90*intIndex,
                                                                         screenWidth - 40,
                                                                         80*intIndex)];
    lblConhecimento2.text = @"0 desconheço e 10 SOU FODA!";
    lblConhecimento2.textAlignment = NSTextAlignmentCenter;
    lblConhecimento2.font = [UIFont boldSystemFontOfSize:14*intIndex];
    lblConhecimento2.lineBreakMode = NSLineBreakByWordWrapping;
    
    lblConhecimento2.minimumScaleFactor = 8.0f/14.0f;

    lblConhecimento2.adjustsFontSizeToFitWidth = YES;
    lblConhecimento2.numberOfLines = 0;
    
    lblConhecimento2.textColor = [UIColor blackColor];

    [self addSubview:lblConhecimento2];
    
    UIView *viewFundo2 = [[UIView alloc] initWithFrame:CGRectMake(20,
                                                                  screenHeight - 80 * intIndex,
                                                                  screenWidth - 40,
                                                                  50)];
    viewFundo2.backgroundColor = [UIColor darkGrayColor];
    viewFundo2 = [[Utils shared] aplicarSombra:viewFundo2];
    [self addSubview:viewFundo2];
    
    UIButton *btnProximo = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2,
                                                                      screenHeight - 75 * intIndex,
                                                                      screenWidth/2,
                                                                      40)];
    [btnProximo addTarget:self action:@selector(avancar)
         forControlEvents:UIControlEventTouchUpInside];
    [btnProximo setTitle:@"Próximo" forState:UIControlStateNormal];
    btnProximo.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [self addSubview:btnProximo];
    
    UIButton *btnCancelar = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                     screenHeight - 75 * intIndex,
                                                                     screenWidth/2,
                                                                     40)];
    [btnCancelar addTarget:self action:@selector(cancelar)
         forControlEvents:UIControlEventTouchUpInside];
    [btnCancelar setTitle:@"Cancelar" forState:UIControlStateNormal];
    btnCancelar.titleLabel.textColor = [UIColor purpleColor]; //[UIColor colorWithRed:255/253 green:255/187 blue:255/194 alpha:1.0];
    btnCancelar.titleLabel.font = [UIFont systemFontOfSize:20];

    [self addSubview:btnCancelar];
    
    return self;
}


- (void)sliderChange:(DKCircularSlider *)sender
{
    if (sender.currentValue == 10) {
    }
}

- (void)avancar
{
    NSNumber *message = [NSNumber numberWithInt:_dkCSlider.currentValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AVANCAR" object:message];
}

- (void)cancelar
{
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    _gestureStartPoint = [touch locationInView:self];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint currentPosition = [touch locationInView:self];
//    
//    CGFloat deltaYY = (_gestureStartPoint.y - currentPosition.y); // positive = up, negative = down
//    
//    CGFloat deltaX = fabs(_gestureStartPoint.x - currentPosition.x); // will always be positive
//    CGFloat deltaY = fabs(_gestureStartPoint.y - currentPosition.y); // will always be positive
//    
//    if (deltaY >= 30 && deltaX <= 80) {
//        if (deltaYY > 0) {
//            [self performSelector:@selector(swipeUp) withObject:nil afterDelay:2];
//        }
//        else {
//            [self performSelector:@selector(swipeDown) withObject:nil afterDelay:2];
//        }
//    }
//}
//
//
//
//- (void)swipeUp
//{
//    int intAtual = _dkCSlider.currentValue + 1;
//    _dkCSlider.currentValue = intAtual;
//    [_dkCSlider movehandleToValue:intAtual];
//}
//
//- (void)swipeDown
//{
//    int intAtual = _dkCSlider.currentValue - 1;
//    _dkCSlider.currentValue = intAtual;
//    [_dkCSlider movehandleToValue:intAtual];
//}

@end
