//
//  UIViewResumo.m
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 20/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UIViewResumo.h"
#import "CandidatoConhecimento+Metodos.h"
#import "GrupoConhecimentos+Metodos.h"
#import "Utils.h"
#import "MDRadialProgressView.h"
#import "ConexaoServidor.h"

@implementation UIViewResumo


- (void)apresentarResumo
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    float intIndex = screenHeight/480;

    UIButton *btnProximo = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                      screenHeight - 60,
                                                                      screenWidth,
                                                                      40)];
    
    [btnProximo addTarget:self action:@selector(encerrar)
         forControlEvents:UIControlEventTouchUpInside];
    [btnProximo setTitle:@"Encerrar" forState:UIControlStateNormal];
    btnProximo.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    if (self.intResultado == 0){
        [btnProximo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [btnProximo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

    [self addSubview:btnProximo];

    NSArray *nsaGrupoConhecimento = [GrupoConhecimentos buscarArrayTodosGrupoConhecimentos];

    [nsaGrupoConhecimento enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        GrupoConhecimentos *parGrupoConhecimentoAtual = obj;
        float fltMedia = [_candidatoAtual calcularPontuacaoMedia:parGrupoConhecimentoAtual];
        
        //Envio de email pelo servidor web.
        if (self.intResultado >= 1){
            if (fltMedia >= 7){
                NSString *strParametros = [NSString stringWithFormat:@"https://ecosonar.com.br/mail/send_mail_ios.php?nome=%@&email=%@&tipo=%@", _candidatoAtual.strNome, _candidatoAtual.strEmail, parGrupoConhecimentoAtual.strGrupoConhecimento];

                NSThread *myThread = [[NSThread alloc] initWithTarget:self
                                                             selector:@selector(enviarEmail:)
                                                               object:strParametros];
                [myThread start];
                _intResultado = 2;
            }
        }
        
        int page = (((int)idx * 130) + 30) * intIndex;
        UILabel *lblGrupoConhecimento = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                             page + 5,
                                                                             screenWidth - 40,
                                                                             30)];
        lblGrupoConhecimento.text = [NSString stringWithFormat:@"%@ - %0.0f Pontos",
                                parGrupoConhecimentoAtual.strGrupoConhecimento,
                                fltMedia];
        lblGrupoConhecimento.textAlignment = NSTextAlignmentCenter;
        lblGrupoConhecimento.font = [UIFont boldSystemFontOfSize:16];
        
        lblGrupoConhecimento.textColor = [UIColor whiteColor];
        lblGrupoConhecimento.backgroundColor = [UIColor darkGrayColor];
        
        UIView *viewFundo = [[UIView alloc] initWithFrame:CGRectMake(20, page + 35, screenWidth -40, 90 * intIndex)];
        viewFundo.backgroundColor = [UIColor whiteColor];
        
        CGRect frame = CGRectMake(45, page + (40*intIndex), 80, 80);
        MDRadialProgressView *radialView5 = (MDRadialProgressView *)[[Utils shared] gerarGrafico:frame comMedia:fltMedia];
        
        [self addSubview:[[Utils shared] aplicarSombra:lblGrupoConhecimento]];
        [self addSubview:[[Utils shared] aplicarSombra:viewFundo]];
        [self addSubview:radialView5];

        
        
        NSArray *nsaCandidatoConecimentos = [CandidatoConhecimento
                                             buscarArrayTodosConhecimentosdoCandidato:_candidatoAtual doGrupoConhecimento:parGrupoConhecimentoAtual];
        UILabel *lblConhecimento = [[UILabel alloc] initWithFrame:CGRectMake(140,
                                                                             13 * intIndex,
                                                                             screenWidth - 140,
                                                                             100)];
        NSString *strDetalhesConhecimento = @"";
        for (int i = 0; i< nsaCandidatoConecimentos.count; i++){
            CandidatoConhecimento *candidatoConhecimentoAtual = [nsaCandidatoConecimentos objectAtIndex:i];
            strDetalhesConhecimento = [strDetalhesConhecimento stringByAppendingFormat:@"%@ - %d\n\n",
                                       candidatoConhecimentoAtual.conhecimento.strConhecimento,
                                       [candidatoConhecimentoAtual.intPontuacao intValue]];
        }
        lblConhecimento.text = strDetalhesConhecimento;
        lblConhecimento.textAlignment = NSTextAlignmentLeft;
        lblConhecimento.font = [UIFont boldSystemFontOfSize:12];
        lblConhecimento.minimumScaleFactor = 8.0f/12.0f;
        
        lblConhecimento.adjustsFontSizeToFitWidth = YES;
        lblConhecimento.numberOfLines = 0;
        
        lblConhecimento.textColor = [UIColor blackColor];
        lblConhecimento.backgroundColor = [UIColor clearColor];
        [viewFundo addSubview:lblConhecimento];

        

    }];
    if (_intResultado == 1){
        NSString *strParametros = [NSString stringWithFormat:@"https://ecosonar.com.br/mail/send_mail_ios.php?nome=Luciano&email=lucianoab@me.com&tipo="];
        [[ConexaoServidor sharedManager] conectarEndereco:strParametros];
    }

}

- (void)encerrar
{
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (void)enviarEmail:(NSString *)strParametros
{
    [[ConexaoServidor sharedManager] conectarEndereco:strParametros];
}

@end
