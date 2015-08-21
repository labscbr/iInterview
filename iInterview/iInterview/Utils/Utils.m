//
//  Utils.m
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "Utils.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"


@implementation Utils

static Utils *_shared = nil;

+ (Utils *)shared
{
    @synchronized([Utils class]) {
        if (!_shared) {
            _shared = [[self alloc] init];
        }
        return _shared;
    }
    return nil;
}

- (BOOL)validarEmail:(NSString*)parEmail
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:parEmail];
}

-(void)mostrarAlerta:(NSString *)parMensagem
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@"Atenção"
                                                         message:parMensagem
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
    [ErrorAlert show];
}

- (MDRadialProgressTheme *)ajustarTema:(float)fltValor
{
    MDRadialProgressTheme *newTheme = [MDRadialProgressTheme standardTheme];
    newTheme.centerColor = [UIColor clearColor];
    newTheme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
    newTheme.sliceDividerHidden = NO;
    newTheme.sliceDividerThickness = 1;

    newTheme.labelColor = [UIColor clearColor];
    newTheme.labelShadowColor = [UIColor clearColor];
    
    if (fltValor >= 7) {
        newTheme.centerColor = [UIColor colorWithRed:231/255.0 green:249/255.0 blue:241/255.0 alpha:1.0];
        newTheme.completedColor = [UIColor colorWithRed:90/255.0 green:212/255.0 blue:39/255.0 alpha:1.0];
        newTheme.incompletedColor = [UIColor colorWithRed:204/255.0 green:249/255.0 blue:201/255.0 alpha:1.0];
    } else {
        newTheme.centerColor = [UIColor colorWithRed:255/255.0 green:225/255.0 blue:223/255.0 alpha:1.0];
        newTheme.completedColor = [UIColor redColor];
        newTheme.incompletedColor = [UIColor colorWithRed:255/255.0 green:189/255.0 blue:161/255.0 alpha:1.0];
    }
    
    return newTheme;
}


- (UIView *)gerarGrafico:(CGRect)parFrame comMedia:(float)parMedia
{
    MDRadialProgressView *radialView5 = [[MDRadialProgressView alloc] initWithFrame:parFrame];
    radialView5.progressTotal = 10;
    radialView5.progressCounter = parMedia;
    radialView5.theme = [self ajustarTema:parMedia];
    return radialView5;
}

- (UIView *)aplicarSombra:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(3, 3);
    view.layer.shadowRadius = 5;
    view.layer.shadowOpacity = 0.5;
    
    return view;
}

@end
