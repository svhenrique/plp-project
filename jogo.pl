main:- nani_search.

nani_search:-
    write('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='), nl,
    write('PROJETO - PARADIGMAS DE LINGUAGENS DE PROGRAMAÇÃO'), nl,
    write('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-='), nl,
    write('Bem vindo ao jogo Nani Search'), nl,
    write('Seu objetivo é procurar a boneca nani que está perdida'), nl, nl,
    observar.

sala(cozinha).  
sala(escritório).
sala('sala de estar').
sala(banheiro).
sala(quarto).
sala(quintal).


localizado(mesa, escritório).
localizado(maça, cozinha).
localizado(lanterna, escritório).
localizado('maquina de lavar', quintal).
localizado(nani, quintal).
localizado(banana, cozinha).
localizado('biscoito treloso', cozinha).
localizado(computador, escritório).

porta('sala de estar', banheiro).
porta(banheiro, 'sala de estar').
porta('sala de estar', quarto).
porta(quarto, 'sala de estar').
porta('sala de estar', cozinha).
porta(cozinha, 'sala de estar').
porta('sala de estar', escritório).
porta(escritório, 'sala de estar').
porta('cozinha', quintal).
porta(quintal, 'cozinha').

comestível(maça).
comestível(banana).
comestível('biscoito treloso').

procurar_comida(X,Y) :-  
  localizado(X,Y),
  comestível(X).

conectado(X,Y) :- porta(X,Y).

observar_coisas(Lugar) :-  
  localizado(X, Lugar),
  tab(2),
  write(X),
  nl,
  fail.
observar_coisas(_).

listar_conectados(Lugar) :-
  conectado(Lugar, X),
  tab(2),
  write(X),
  nl,
  fail.
listar_conectados(_).

observar :-
  aqui(quintal),
  turno(noite),
  não_tenho(lanterna),
  write('Onde eu estou: '), write('quintal'), nl,
  write('O que eu posso ver:'), nl, tab(2),
  write('Aqui está muito escuro, não consigo ver nada!'), nl,
  write('Onde posso ir:'), nl,
  listar_conectados(quintal).
observar :-
  aqui(Lugar),
  write('Onde eu estou: '), write(Lugar), nl,
  write('O que eu posso ver:'), nl,
  observar_coisas(Lugar),
  write('Onde posso ir:'), nl,
  listar_conectados(Lugar).

pode_ir(Lugar):- 
  aqui(X),
  conectado(X, Lugar).
pode_ir(Lugar):-
  aqui(X),
  X = Lugar,
  write('Você já está aqui...').
pode_ir(Lugar):-
  write('Daqui você não consegue chegar lá...'), nl,
  fail.

ir_para(Lugar):-  
  pode_ir(Lugar),
  mover(Lugar),
  observar.

mover(Lugar):-
  dynamic(aqui(X)),
  retract(aqui(X)),
  asserta(aqui(Lugar)).

posso_pegar(Objeto) :-
  aqui(Lugar),
  localizado(Objeto, Lugar).
posso_pegar(Objeto) :-
  write('Não tem '), write(Objeto),
  write(' aqui.'),
  nl, fail.

pegar_objeto(lanterna):-
  posso_pegar(lanterna),  
  dynamic(tenho('nada')),
  dynamic(não_tenho(lanterna)),
  dynamic(localizado(lanterna, _)),
  retract(localizado(lanterna,_)),
  retract(tenho('nada')),
  retract(não_tenho(lanterna)),
  asserta(tenho(lanterna)),
  asserta(não_tenho('nada')),
  write('Você pegou o objeto: '), write('lanterna'), nl.
pegar_objeto(X):-
  posso_pegar(X),  
  dynamic(tenho(X)),
  dynamic(não_tenho(X)),
  dynamic(localizado(X, _)),
  retract(localizado(X,_)),
  retract(tenho(X)),
  asserta(tenho(X)),
  write('Você pegou o objeto: '), write(X), nl.

pegar_nani:-
    posso_pegar(nani),
    write('Você conseguiu achar a nani, parabéns!!'), nl,
    write('O jogo foi finalizado...'), nl,
    write('Reinicie o jogo usando a operação [jogo] se quiser jogar novamente'), nl.
pegar_nani:-
    write('Logo, nani não está aqui, continue procurando!'), nl, fail.

turno(noite).
aqui('sala de estar').
tenho('nada').
não_tenho(lanterna).
