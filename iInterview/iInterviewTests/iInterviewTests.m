//
//  iInterviewTests.m
//  iInterviewTests
//
//  Created by Luciano A. Baramarchi on 18/08/15.
//  Copyright (c) 2015 Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Candidatos+Metodos.h"
#import "Conhecimentos+Metodos.h"
#import "GrupoConhecimentos+Metodos.h"

@interface iInterviewTests : XCTestCase

@end

@implementation iInterviewTests

- (void)testarCandidato {
    NSString *strEmail = @"lucianoab@me.com";
    NSString *strNome  = @"Luciano Andre";
    
    Candidatos *candidatoInserido = [Candidatos adicionarCandidato:strNome comEmail:strEmail];
    XCTAssertEqualObjects(candidatoInserido.strNome,@"Luciano Andre");
    
    Candidatos *candidato = [Candidatos buscarCandidato:strEmail];
    XCTAssertEqualObjects(candidato, candidatoInserido, @"Não conseguiu localizar candidato");
    
    NSFetchedResultsController *nsfrcTeste = [Candidatos buscarTodosCandidatos];
    XCTAssertGreaterThan([nsfrcTeste.fetchedObjects count], 0, @"Não conseguiu localizar candidato");

    BOOL retorno = [Candidatos apagarCandidato:strEmail];
    XCTAssertTrue(retorno,"Não conseguiu apagar candidato");
}

- (void)testarConhecimento {
    NSString *strTeste = @"iOS";

    Conhecimentos *conhecimentoInserido = [Conhecimentos adicionarConhecimento:strTeste];
    XCTAssertEqualObjects(conhecimentoInserido.strConhecimento,  @"iOS");
    
    Conhecimentos *conhecimento = [Conhecimentos buscarConhecimento:strTeste];
    XCTAssertEqualObjects(conhecimento, conhecimentoInserido, @"Não conseguiu localizar conhecimento");
    
    NSFetchedResultsController *nsfrcTeste = [Conhecimentos buscarTodosConhecimentos];
    XCTAssertGreaterThan([nsfrcTeste.fetchedObjects count], 0, @"Não conseguiu localizar conhecimento");
    
    BOOL retorno = [Conhecimentos apagarConhecimento:strTeste];
    XCTAssertTrue(retorno,"Não conseguiu apagar conhecimento");
}

- (void)testarGrupoConhecimento {
    NSString *strTeste = @"iOS2";
    
    GrupoConhecimentos *grupoConhecimentoInserido = [GrupoConhecimentos adicionarGrupoConhecimento:strTeste];
    XCTAssertEqualObjects(grupoConhecimentoInserido.strGrupoConhecimento,  strTeste);
    
    GrupoConhecimentos *grupoConhecimento = [GrupoConhecimentos buscarGrupoConhecimento:strTeste];
    XCTAssertEqualObjects(grupoConhecimento, grupoConhecimentoInserido, @"Não conseguiu localizar grupoConhecimento");
    
    NSFetchedResultsController *nsfrcTeste  = [GrupoConhecimentos buscarTodosGruposConhecimentos];
    XCTAssertGreaterThan([nsfrcTeste.fetchedObjects count], 0, @"Não conseguiu localizar grupoConhecimento");
    
    BOOL retorno = [GrupoConhecimentos apagarGrupoConhecimento:strTeste];
    XCTAssertTrue(retorno,"Não conseguiu apagar grupoConhecimento");
}



@end



/*
 
 - (void)testarBaseInicial {
     GrupoConhecimentos *grupoConhecimentoFrontEnd = [GrupoConhecimentos adicionarGrupoConhecimento:@"Front-End"];
     GrupoConhecimentos *grupoConhecimentoBackEnd  = [GrupoConhecimentos adicionarGrupoConhecimento:@"Back-End"];
     GrupoConhecimentos *grupoConhecimentoMobile   = [GrupoConhecimentos adicionarGrupoConhecimento:@"Mobile"];
 
     Conhecimentos *conhecimentoHTML = [Conhecimentos adicionarConhecimento:@"HTML"];
     conhecimentoHTML.grupoConhecimento = grupoConhecimentoFrontEnd;
 
     Conhecimentos *conhecimentoCSS = [Conhecimentos adicionarConhecimento:@"CSS"];
     conhecimentoCSS.grupoConhecimento = grupoConhecimentoFrontEnd;
 
     Conhecimentos *conhecimentoJS = [Conhecimentos adicionarConhecimento:@"JavaScript"];
     conhecimentoJS.grupoConhecimento = grupoConhecimentoFrontEnd;
 
     Conhecimentos *conhecimentoPY = [Conhecimentos adicionarConhecimento:@"Python"];
     conhecimentoPY.grupoConhecimento = grupoConhecimentoBackEnd;
 
     Conhecimentos *conhecimentoDJ = [Conhecimentos adicionarConhecimento:@"Django"];
     conhecimentoDJ.grupoConhecimento = grupoConhecimentoBackEnd;
 
     Conhecimentos *conhecimentoiOS = [Conhecimentos adicionarConhecimento:@"Desenvolvimento iOS"];
     conhecimentoiOS.grupoConhecimento = grupoConhecimentoMobile;
 
     Conhecimentos *conhecimentoAndroid = [Conhecimentos adicionarConhecimento:@"Desenvolvimento Android"];
     conhecimentoAndroid.grupoConhecimento = grupoConhecimentoMobile;
 
     XCTAssertEqualObjects(grupoConhecimentoFrontEnd.strGrupoConhecimento, @"Front-End");
 }

 - (void)setUp {
 [super setUp];
 // Put setup code here. This method is called before the invocation of each test method in the class.
 }
 
 - (void)tearDown {
 // Put teardown code here. This method is called after the invocation of each test method in the class.
 [super tearDown];
 }
 
 - (void)testExample {
 // This is an example of a functional test case.
 XCTAssert(YES, @"Pass");
 }
 */
