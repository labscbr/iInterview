//
//  ViewController.m
//  iInterview
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright (c) 2015 Luciano. All rights reserved.
//

#import "CandidatosViewController.h"
#import "Candidatos+Metodos.h"
#import "UICandidatoCell.h"
#import "UIViewResumo.h"
#import "EntrevistaViewController.h"

@interface CandidatosViewController ()
@property (weak, nonatomic) IBOutlet UILabel     *lblTitulo;
@property (weak, nonatomic) IBOutlet UIButton    *btnAdicionar;
@property (weak, nonatomic) IBOutlet UITableView *tbvCandidatos;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segFiltro;

@property (strong, nonatomic) NSFetchedResultsController *nsfrcCandidatos;
@property (strong, nonatomic) NSMutableArray *nsmaResultados;
@property (weak, nonatomic) EntrevistaViewController *vcEntrevista;


@end

@implementation CandidatosViewController

# pragma mark -
# pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [_tbvCandidatos setHidden:YES];
    [_btnAdicionar setHidden:YES];
    [_segFiltro setHidden:YES];
    
    _nsmaResultados = [[NSMutableArray alloc] init];
    
    [self criarFiltro];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_lblTitulo.tag != 2) {
    _lblTitulo.tag = _lblTitulo.frame.origin.y;
    _lblTitulo.frame = CGRectMake(_lblTitulo.frame.origin.x,
                                  200,
                                  _lblTitulo.frame.size.width,
                                  _lblTitulo.frame.size.height);

    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{                          _lblTitulo.frame = CGRectMake(_lblTitulo.frame.origin.x,
                                                                                          _lblTitulo.tag,
                                                                                          _lblTitulo.frame.size.width,
                                                                                          _lblTitulo.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [_tbvCandidatos setHidden:NO];
                         [_btnAdicionar setHidden:NO];
                         [_segFiltro setHidden:NO];
                         _lblTitulo.tag = 2;
                     }];
    }
    
    _nsfrcCandidatos = [Candidatos buscarTodosCandidatos];
    [_tbvCandidatos reloadData];
}


# pragma mark -
# pragma mark Funcoes

- (void)criarFiltro
{
    NSArray *arrSegItens = [GrupoConhecimentos buscarArrayTodosGrupoConhecimentos];
    for (int i=0; i< arrSegItens.count; i++){
        GrupoConhecimentos *grupoConhecimento = [arrSegItens objectAtIndex:i];
        [_segFiltro insertSegmentWithTitle:grupoConhecimento.strGrupoConhecimento atIndex:i+2 animated:NO];
    }

    [_segFiltro removeSegmentAtIndex:1 animated:NO];
}


- (IBAction)valueChanged:(UISegmentedControl *)segmentedControl {
    
    _nsfrcCandidatos = [Candidatos buscarTodosCandidatos];
    [_tbvCandidatos reloadData];
//    for (int i=0; i < _nsfrcCandidatos.fetchedObjects.count; i++){
//        UICandidatoCell *cell =
//        [_tbvCandidatos deleteRowsAtIndexPaths: withRowAnimation:UITableViewRowAnimationFade];
//    }
}


# pragma mark -
# pragma mark TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo =  [[_nsfrcCandidatos sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Candidatos";
    
    UICandidatoCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UICandidatoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    Candidatos *candidato = [_nsfrcCandidatos objectAtIndexPath:indexPath];
    cell.candidato = candidato;
    cell.delegate = cell;
    
    [cell desenharGraficosComFiltro:(int)(_segFiltro.selectedSegmentIndex - 1)];
    
    [_nsmaResultados insertObject:cell.nsmaResultados atIndex:indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 162;
    
    if (_segFiltro.selectedSegmentIndex > 0) {
        NSMutableArray *nsmaResultadoAtual = [_nsmaResultados objectAtIndex:indexPath.row];
        NSString *strResultado = [nsmaResultadoAtual objectAtIndex:(_segFiltro.selectedSegmentIndex - 1)];
        
        if ([strResultado isEqualToString:@"0"])
        {
            height = 0;
        }
        
    }
    
    return height;
}

# pragma mark -
# pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];

    UIViewResumo *viewResumo = [[UIViewResumo alloc] initWithFrame:vc.view.frame];
    
    viewResumo.delegate = self;
    viewResumo.intResultado = 0;
    viewResumo.candidatoAtual = [_nsfrcCandidatos objectAtIndexPath:indexPath];
    
    [vc.view addSubview:viewResumo];
    [viewResumo apresentarResumo];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Candidatos *candidato = [_nsfrcCandidatos objectAtIndexPath:indexPath];
        [Candidatos apagarCandidato:candidato.strEmail];
        // Delete the row from the data source
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        _nsfrcCandidatos = [Candidatos buscarTodosCandidatos];
        [tableView reloadData];
    } 
}

# pragma mark -
# pragma mark Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (_vcEntrevista == nil){
        _vcEntrevista = (EntrevistaViewController *)segue.destinationViewController;
    }
}

@end
