//
//  EntrevistaViewController.m
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright © 2015 Luciano. All rights reserved.
//

#import "EntrevistaViewController.h"
#import "Utils.h"
#import "GrupoConhecimentos+Metodos.h"
#import "Conhecimentos+Metodos.h"
#import "Candidatos+Metodos.h"
#import "CandidatoConhecimento+Metodos.h"
#import "DDPageControl.h"
#import "UIViewConhecimento.h"
#import "UIViewResumo.h"

@class DDPageControl ;


@interface EntrevistaViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIScrollView *scrvEntrevista;
@property (weak, nonatomic) IBOutlet UIView *viewCadastro;

@property (strong, nonatomic) DDPageControl *pageControl;

@property (strong, nonatomic) NSArray *nsaGrupoConhecimentos;
@property (strong, nonatomic) NSArray *nsaConhecimentos;
@property (strong, nonatomic) NSArray *nsaCandidatos;
@property (strong, nonatomic) Candidatos *candidatoAtual;

@property CGFloat width;
@property CGFloat height;

@property int intPageAtual;
@property NSNumber *numPontuacao;

- (IBAction)iniciarEntrevista;

@end

@implementation EntrevistaViewController

# pragma mark -
# pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(avancarEntrevista:)
                                                 name:@"AVANCAR"
                                               object:nil];
    [self setNeedsStatusBarAppearanceUpdate];
    [super viewDidLoad];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
 - (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLayoutSubviews
{
    //Criacao do scroll e inicializacao dos arrays
    _nsaGrupoConhecimentos = [GrupoConhecimentos buscarArrayTodosGrupoConhecimentos];
    _nsaConhecimentos = [Conhecimentos buscarArrayTodosConhecimentos];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    _width  = screenSize.width;
    _height = screenSize.height;
    
    [self criarScroll];
}

# pragma mark -
# pragma mark TextField Delegate

//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return TRUE;
//}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}


# pragma mark -
# pragma mark Controle do teclado

- (void)esconderTeclado{
    [_txtEmail resignFirstResponder];
    [_txtNome resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self esconderTeclado];
}

# pragma mark -
# pragma mark Criar ScrollView

- (void)criarScroll
{
    //Configuracao inicial do ScrollView
    _scrvEntrevista.pagingEnabled = YES;
    [_scrvEntrevista setFrame:CGRectMake(0, 0, _width, _height)];
    _scrvEntrevista.contentSize = CGSizeMake(_width * (_nsaConhecimentos.count + 2), _height - 20);
    _scrvEntrevista.showsHorizontalScrollIndicator = NO;
    _scrvEntrevista.showsVerticalScrollIndicator = NO;
    _scrvEntrevista.scrollsToTop = NO;
    _scrvEntrevista.delegate = self;
    _scrvEntrevista.tag = 113;
    _viewCadastro.frame = CGRectMake(0, 0, _width, _height);

    _intPageAtual = 1;
}

- (void)criarPageControl
{
    //Configuracao do pageControl
    _pageControl= [[DDPageControl alloc] init];
    [_pageControl setCenter: CGPointMake(_width / 2, _height - 10)] ;
    [_pageControl setNumberOfPages: _nsaConhecimentos.count + 1];
    [_pageControl setCurrentPage: 0] ;
    [_pageControl setDefersCurrentPageDisplay: YES] ;
    [_pageControl setType: DDPageControlTypeOnFullOffEmpty] ;
    [_pageControl setOnColor: [UIColor whiteColor]];
    [_pageControl setOffColor: [UIColor whiteColor]];
    [_pageControl setIndicatorDiameter: 5.0f] ;
    [_pageControl setIndicatorSpace: 5.0f] ;
    [_pageControl setHidden:NO];
    [self.view addSubview:_pageControl];
}

- (void)criarEntrevista
{
    //adicionar itens da entrevista
    [_nsaConhecimentos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int page = (idx + 1) * _width;
        UIViewConhecimento *viewConhecimento = [[UIViewConhecimento alloc]
                                                initWithFrame:CGRectMake(page,
                                                                         0,
                                                                         _width,
                                                                         _height)
                                                naPagina:(int)idx
                                                comObjeto:obj];
        
        viewConhecimento.delegate = self;
        [_scrvEntrevista addSubview:viewConhecimento];
    }];
    
    [self criarPageControl];
}

- (void)criarResumo
{
    int page = (_nsaConhecimentos.count + 1) * _width;

    UIViewResumo *viewResumo = [[UIViewResumo alloc] initWithFrame:CGRectMake(page,
                                                                     0,
                                                                     _width,
                                                                     _height)];
    
    viewResumo.delegate = self;
    viewResumo.intResultado = 1;
    viewResumo.candidatoAtual = _candidatoAtual;
    [_scrvEntrevista addSubview:viewResumo];
    [viewResumo apresentarResumo];
}
# pragma mark -
# pragma mark ScrollView Delegate

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//}
//
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
////    int page = _scrvEntrevista.contentOffset.x/_scrvEntrevista.frame.size.width;
////    _pageControl.currentPage = page;
//}

# pragma mark -
# pragma mark Botoes e Funcoes

- (IBAction)iniciarEntrevista
{
    //remover antigas views;
    [self removerViewsAntigas];
    
    //Valida se os campos foram preenchidos
    _intPageAtual = 0;
    if (_txtNome.text.length <= 0){
        [[Utils shared] mostrarAlerta:@"É obrigatório digitar o seu nome!"];
    } else if ([[Utils shared] validarEmail:_txtEmail.text] == FALSE){
        [[Utils shared] mostrarAlerta:@"É obrigatório digitar um e-mail válido!"];
    } else {
        if (_candidatoAtual != nil){
            [_candidatoAtual apagarCandidato];
        }
        _candidatoAtual = [Candidatos adicionarCandidato:_txtNome.text comEmail:_txtEmail.text];
        [self criarEntrevista];
        
        //vai para a primeira página
        [self avancarEntrevista:nil];
    }
}

- (IBAction)cancelar:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_candidatoAtual apagarCandidato];
    _intPageAtual = 0;
    [_pageControl removeFromSuperview];
    _pageControl = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)avancarEntrevista:(NSNotification *) notification
{
    if ([notification.object isKindOfClass:[NSNumber class]] && _intPageAtual >= 1)
    {
        NSNumber *numPontuacao = (NSNumber *)notification.object;
        Conhecimentos *conhecimentoAtual = [_nsaConhecimentos objectAtIndex:_intPageAtual - 1];
        CandidatoConhecimento *candidatoConhecimentoAtual = [CandidatoConhecimento adicionarCandidato:_candidatoAtual
                                                                                      comConhecimento:conhecimentoAtual];
        [candidatoConhecimentoAtual definirPontuacaoConhecimento:[numPontuacao intValue]];
    }

    _pageControl.currentPage = _intPageAtual ;
    [_pageControl updateCurrentPageDisplay];

    NSLog(@"pagina = %d", _intPageAtual);
    _intPageAtual ++;
    CGRect frame = _scrvEntrevista.frame;
    frame.origin.x = frame.size.width * _intPageAtual + 1;
    frame.origin.y  = 0;
    [_scrvEntrevista scrollRectToVisible:frame animated:YES];
    if (_intPageAtual > ([_nsaConhecimentos count])){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self criarResumo];
        _intPageAtual = 0;
    }
    notification = nil;

}

- (void)removerViewsAntigas
{
    for (UIView *subview in [self.view subviews]) {
        if (subview.tag >= 1000) {
            [subview removeFromSuperview];
        }
    }
}

/*
- (void)mostrarAnimacaoSouFoda
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    int intX = (screenWidth - 230) / 2 ;
    int intY = (screenHeight - 230) / 1.5  ;
    
    UIImageView *imgvFoda = [[UIImageView alloc] initWithFrame:CGRectMake(intX,
                                                                          intY,
                                                                          230,
                                                                          230)];
    imgvFoda.image = [UIImage imageNamed:@"foda.png"];
    [UIView animateWithDuration:2.0
                          delay:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         [self.view addSubview:imgvFoda];

                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:2.0
                                               delay:2.0
                                             options:UIViewAnimationOptionTransitionCrossDissolve
                                          animations:^{
                                              [imgvFoda removeFromSuperview];
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                     }];
}
*/

@end
