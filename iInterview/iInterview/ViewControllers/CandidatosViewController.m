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

@interface CandidatosViewController ()
@property (weak, nonatomic) IBOutlet UILabel     *lblTitulo;
@property (weak, nonatomic) IBOutlet UIButton    *btnAdicionar;
@property (weak, nonatomic) IBOutlet UITableView *tbvCandidatos;

@property (strong, nonatomic) NSFetchedResultsController *nsfrcCandidatos;

@end

@implementation CandidatosViewController

# pragma mark -
# pragma mark View LifeCycle

- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
    [_tbvCandidatos setHidden:YES];
    [_btnAdicionar setHidden:YES];
    [super viewDidLoad];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
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
                         _lblTitulo.tag = 2;
                     }];
    }
    
    _nsfrcCandidatos = [Candidatos buscarTodosCandidatos];
    [_tbvCandidatos reloadData];
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
    
    [cell desenharGraficos];
    
    return cell;
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


@end
