% Base de dados de comandos Linux e suas informações
command_info(ls, 'Lista o conteudo de um diretorio.', ['l', 'a', 't']).
command_info(cp, 'Copia arquivos ou diretorios.', ['r', 'i', 'v']).
command_info(mkdir, 'Cria um diretorio.', ['p', 'v']).
command_info(rm, 'Remove arquivos ou diretorios.', ['r', 'f', 'i']).
command_info(touch, 'Cria um arquivo vazio.', ['c', 'm', 'd']).
command_info(pwd, 'Mostra o diretorio atual ', []).
command_info(wget, 'Baixa arquivos do FTP ou de servidores web', []).
command_info(cat, 'Mostra o que esta escrito no arquivo em formato de texto', []).
command_info(free, 'Mostra a memoria livre e utilizada, precisa ser utilizada com a flag -h', []).
command_info(who, 'Exibe quem esta atualmente logado no sistema', []).
command_info(uname, 'Exibe o sistema operacional utilizado', ['r', 'a']).
command_info(ifconfig, 'Mostra o endereço de todas sa interfaces de rede',[]).
command_info(hostname, 'Mostra o hostname', ['i']).
command_info(history, 'Exibe o historico de comandos digitados no terminal', []).
command_info(echo, 'Mostra o valor digitado', []).

% Descrições das flags
flag_description('l', 'Exibe detalhes como permissões, proprietário, tamanho, data de modificação, etc.').
flag_description('a', 'Mostra arquivos ocultos.').
flag_description('t', 'Ordena por data de modificação.').
flag_description('r', 'Copia recursivamente diretórios e seus conteúdos.').
flag_description('i', 'Pede confirmação antes de sobrescrever arquivos existentes.').
flag_description('v', 'Exibe mensagens detalhadas durante a cópia.').
flag_description('p', 'Cria diretórios pai, se necessário.').
flag_description('f', 'Força a remoção sem confirmação.').
flag_description('c', 'Não cria o arquivo se ele não existir.').
flag_description('m', 'Muda a data de modificação do arquivo.').
flag_description('d', 'Usa a data especificada em vez da atual.').
flag_description('r', 'Mostra informações do sistema').
flag_description('a', 'Mostra a versão do kernel').
flag_description('i', 'Mostra o endereço de IP do sistema').

% Regras para interação com o usuário
start_chat :-
    write('Bem-vindo ao ChatBot de Comandos Linux!'), nl,
    write('Digite um comando Linux:'), nl.

handle_input(Command) :-
    command_info(Command, Description, Flags),
    write('Este comando '), write(Description), nl,
    (   Flags = [] ->
        write('Exemplo de uso: '), write(Command), nl
    ;   write('Opções de flags: '), write(Flags), nl,
        write('Você gostaria de saber sobre alguma dessas flags? (sim/nao)'), nl,
        read(Choice),
        handle_choice(Choice, Command, Flags)
    ),
    ask_another_command.

handle_input(_) :-
    write('Comando não reconhecido. Por favor, digite outro comando.'), nl,
    ask_another_command.

handle_choice(sim, Command, Flags) :-
    write('As flags disponíveis são: '), write(Flags), nl,
    write('Digite a flag que você gostaria de saber mais: '), nl,
    read(Flag),
    (   member(Flag, Flags) ->
        handle_flag(Command, Flag)
    ;   write('Flag não reconhecida. Por favor, digite uma flag válida.'), nl,
        handle_choice(sim, Command, Flags)
    ).

handle_choice(nao, _, _) :-
    write('Obrigado por usar o ChatBot de Comandos Linux!'), nl,
    ask_another_command.

handle_flag(Command, Flag) :-
    flag_description(Flag, Description),
    write('A flag '), write(Flag), write(' faz: '), write(Description), nl,
    write('Exemplo de uso: '), write(Command), write('  -'), write(Flag), nl.

ask_another_command :-
    write('Você deseja saber sobre outro comando? (sim/nao)'), nl,
    read(Choice),
    handle_another_command_choice(Choice).

handle_another_command_choice(sim) :-
    chat.

handle_another_command_choice(nao) :-
    write('Obrigado por usar o ChatBot de Comandos Linux!'), nl.

chat :-
    start_chat,
    read(Command),
    atom_string(CommandAtom, Command),
    handle_input(CommandAtom).
