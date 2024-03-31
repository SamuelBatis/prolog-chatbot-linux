% Comandos e suas respectivas descrições
resposta(ls, 'ls lista os arquivos e diretórios no diretório atual.', ['a', 'l', 'h']).
resposta(pwd, 'pwd mostra o diretório atual.', []).
resposta(cd, 'cd muda o diretório atual.', []).
resposta(mkdir, 'mkdir cria um diretório.', ['p']).
resposta(rmdir, 'rmdir remove um diretório vazio.', []).
resposta(touch, 'touch cria um arquivo vazio.', []).
resposta(cp, 'cp copia arquivos e diretórios.', ['r']).
resposta(mv, 'mv move arquivos e diretórios.', []).
resposta(rm, 'rm remove arquivos e diretórios.', ['r', 'f']).
resposta(man, 'man exibe o manual de um comando.', []).

% Descrições das flags para cada comando
descricao_flag(ls, 'a', 'Mostra todos os arquivos, incluindo os ocultos.').
descricao_flag(ls, 'l', 'Exibe detalhes sobre os arquivos, incluindo permissões, proprietário, grupo, tamanho, data de modificação e nome do arquivo.').
descricao_flag(ls, 'h', 'Exibe tamanhos de arquivo legíveis para humanos (por exemplo, 1K, 234M, 2G).').
descricao_flag(mkdir, 'p', 'Cria todos os diretórios necessários, incluindo todos os intermediários.').
descricao_flag(cp, 'r', 'Copia diretórios recursivamente.').
descricao_flag(rm, 'r', 'Remove diretórios e seus conteúdos recursivamente.').
descricao_flag(rm, 'f', 'Remove os arquivos sem perguntar por confirmação.').

% Regra para responder ao comando e suas flags
responder_comando(Comando) :-
    resposta(Comando, Descricao, Flags),
    write(Descricao), nl,
    (Flags \== [] -> write('Flags disponíveis: '), write(Flags), nl; true).

% Regra para responder à consulta sobre uma flag específica
responder_flag(Comando, Flag) :-
    descricao_flag(Comando, Flag, Descricao),
    write('A flag '), write(Flag), write(' '), write(Descricao), nl.
responder_flag(_, Flag) :-
    write('Flag '), write(Flag), write(' não reconhecida.'), nl.

% Regra para listar as descrições das flags
listar_flags([]).
listar_flags([Flag|Resto]) :-
    descricao_flag(_, Flag, Descricao),
    write(' - '), write(Flag), write(': '), write(Descricao), nl,
    listar_flags(Resto).

% Predicado principal que lê o comando digitado pelo usuário e responde
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
