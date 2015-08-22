//
//  UICandidatoCell.h
//  iInterview
//
//  Created by Luciano A. Baramarcchi on 21/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Candidatos+Metodos.h"

@interface UICandidatoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIView *viewFundo1;
@property (weak, nonatomic) IBOutlet UIView *viewFundo2;

@property (weak, nonatomic) Candidatos *candidato;
@property (assign, nonatomic) int intGrupoConhecimento;

- (void)desenharGraficosComFiltro:(int)intFiltro;

@end
