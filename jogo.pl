sala(cozinha).
sala(escritório).
sala('sala de estar').
sala(banheiro).
sala(quarto).
sala(quintal).


localizado(mesa, escritório).
localizado(maça, cozinha).
localizado(lanterna, mesa).
localizado('maquina de lavar', quintal).
localizado(nani, 'washing machine').
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

desligado(lanterna).

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
  aqui(Lugar),
  write('Onde você está: '), write(Lugar), nl,
  write('Você pode ver:'), nl,
  observar_coisas(Lugar),
  write('Você pode ir:'), nl,
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

aqui(cozinha).
