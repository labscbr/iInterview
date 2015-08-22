//
//  UICandidatoCell.m
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 21/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "UICandidatoCell.h"
#import "MDRadialProgressView.h"
#import "Utils.h"

@implementation UICandidatoCell


- (void)desenharGraficosComFiltro:(int)intFiltro
{
    self.lblNome.text  = _candidato.strNome;
    self.lblEmail.text = _candidato.strEmail;
        
    _viewFundo1 = [[Utils shared] aplicarSombra:_viewFundo1];
    _viewFundo2 = [[Utils shared] aplicarSombra:_viewFundo2];
    
    for (UIView *subview in [self subviews]) {
        if (subview.tag >= 1000) {
            [subview removeFromSuperview];
        }
    }
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    
    NSArray *nsaGrupoConhecimento = [GrupoConhecimentos buscarArrayTodosGrupoConhecimentos];

    [nsaGrupoConhecimento enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        GrupoConhecimentos *parGrupoConhecimentoAtual = obj;
        float fltMedia = [_candidato calcularPontuacaoMedia:parGrupoConhecimentoAtual];
        if (intFiltro == idx && fltMedia < 7){
            [self setHidden:YES];
        } else {
            int intX = (screenWidth/(nsaGrupoConhecimento.count+1) + 25) * idx + 40;
            UILabel *lblConhecimento = [[UILabel alloc] initWithFrame:CGRectMake(intX-25,
                                                                                 70,
                                                                                 100,
                                                                                 20)];
            lblConhecimento.text = [NSString stringWithFormat:@"%@ - %0.0f",
                                    parGrupoConhecimentoAtual.strGrupoConhecimento,
                                    fltMedia];
            lblConhecimento.textAlignment = NSTextAlignmentCenter;
            lblConhecimento.font = [UIFont boldSystemFontOfSize:12];
            lblConhecimento.textColor = [UIColor blackColor];
            lblConhecimento.tag = 1000;
            
            CGRect frame = CGRectMake(intX, 95, 50, 50);
            MDRadialProgressView *radialView5 = (MDRadialProgressView *)[[Utils shared] gerarGrafico:frame comMedia:fltMedia];
            radialView5.tag = 1001;
            
            [self addSubview:radialView5];
            [self addSubview:lblConhecimento];
        }
        
        
    }];

}
@end
