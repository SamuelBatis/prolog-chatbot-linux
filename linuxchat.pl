% Comandos e suas respectivas descri��es
resposta(ls, 'ls lista os arquivos e diret�rios no diret�rio atual.', ['a', 'l', 'h']).
resposta(pwd, 'pwd mostra o diret�rio atual.', []).
resposta(cd, 'cd muda o diret�rio atual.', []).
resposta(mkdir, 'mkdir cria um diret�rio.', ['p']).
resposta(rmdir, 'rmdir remove um diret�rio vazio.', []).
resposta(touch, 'touch cria um arquivo vazio.', []).
resposta(cp, 'cp copia arquivos e diret�rios.', ['r']).
resposta(mv, 'mv move arquivos e diret�rios.', []).
resposta(rm, 'rm remove arquivos e diret�rios.', ['r', 'f']).
resposta(man, 'man exibe o manual de um comando.', []).

% Descri��es das flags para cada comando
descricao_flag(ls, 'a', 'Mostra todos os arquivos, incluindo os ocultos.').
descricao_flag(ls, 'l', 'Exibe detalhes sobre os arquivos, incluindo permiss�es, propriet�rio, grupo, tamanho, data de modifica��o e nome do arquivo.').
descricao_flag(ls, 'h', 'Exibe tamanhos de arquivo leg�veis para humanos (por exemplo, 1K, 234M, 2G).').
descricao_flag(mkdir, 'p', 'Cria todos os diret�rios necess�rios, incluindo todos os intermedi�rios.').
descricao_flag(cp, 'r', 'Copia diret�rios recursivamente.').
descricao_flag(rm, 'r', 'Remove diret�rios e seus conte�dos recursivamente.').
descricao_flag(rm, 'f', 'Remove os arquivos sem perguntar por confirma��o.').

% Regra para responder ao comando e suas flags
responder_comando(Comando) :-
    resposta(Comando, Descricao, Flags),
    write(Descricao), nl,
    (Flags \== [] -> write('Flags dispon�veis: '), write(Flags), nl; true).

% Regra para responder � consulta sobre uma flag espec�fica
responder_flag(Comando, Flag) :-
    descricao_flag(Comando, Flag, Descricao),
    write('A flag '), write(Flag), write(' '), write(Descricao), nl.
responder_flag(_, Flag) :-
    write('Flag '), write(Flag), write(' n�o reconhecida.'), nl.

% Regra para listar as descri��es das flags
listar_flags([]).
listar_flags([Flag|Resto]) :-
    descricao_flag(_, Flag, Descricao),
    write(' - '), write(Flag), write(': '), write(Descricao), nl,
    listar_flags(Resto).

% Predicado principal que l� o comando digitado pelo usu�rio e responde
iniciar_linux :-
    write('Digite um comando Linux: '),
    read(Comando),
    responder_comando(Comando),
    (resposta(Comando, _, Flags), Flags \== [] ->
        write('Digite uma flag, se desejar, ou pressione Enter para sair: '),
        read(Flag),
        (Flag \== '' -> responder_flag(Comando, Flag), iniciar_linux; true)
    ; true).

% Exemplo de consulta: iniciar_linux.
