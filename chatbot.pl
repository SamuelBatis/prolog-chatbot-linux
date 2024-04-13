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
command_info(find, 'Busca arquivos e diretórios.', ['type', 'name', 'size']).
command_info(tar, 'Compacta ou extrai arquivos.', ['c', 'x', 'v']).
command_info(chmod, 'Altera as permissões de acesso de arquivos ou diretórios.', ['u', 'g', 'o']).
command_info(df, 'Exibe o espaço livre e usado em sistemas de arquivos.', ['h', 'T', 't']).
command_info(du, 'Exibe o espaço ocupado por arquivos e diretórios.', ['h', 's', 'c']).
command_info(grep, 'Filtra linhas de texto que correspondem a um padrão.', ['i', 'v', 'c']).

% Descrições das flags por comando
flag_description(ls, 'l', 'Exibe detalhes como permissões, proprietário, tamanho, data de modificação, etc.').
flag_description(ls, 'a', 'Mostra arquivos ocultos.').
flag_description(ls, 't', 'Ordena por data de modificação.').
flag_description(cp, 'r', 'Copia recursivamente diretórios e seus conteúdos.').
flag_description(cp, 'i', 'Pede confirmação antes de sobrescrever arquivos existentes.').
flag_description(cp, 'v', 'Exibe mensagens detalhadas durante a cópia.').
flag_description(mkdir, 'p', 'Cria diretórios pai, se necessário.').
flag_description(mkdir, 'v', 'Exibe mensagens detalhadas durante a criação.').
flag_description(rm, 'r', 'Remove arquivos ou diretórios recursivamente.').
flag_description(rm, 'f', 'Força a remoção sem confirmação.').
flag_description(rm, 'i', 'Pede confirmação antes de remover cada arquivo ou diretório.').
flag_description(touch, 'c', 'Não cria o arquivo se ele não existir.').
flag_description(touch, 'm', 'Muda a data de modificação do arquivo.').
flag_description(touch, 'd', 'Usa a data especificada em vez da atual.').
flag_description(uname, 'r', 'Mostra informações do sistema').
flag_description(uname, 'a', 'Mostra a versão do kernel').
flag_description(find, 'type', 'Especifica o tipo de arquivo a ser buscado (e.g., f para arquivo, d para diretório).').
flag_description(find, 'name', 'Busca por arquivos com um determinado nome.').
flag_description(find, 'size', 'Busca por arquivos com um tamanho específico.').
flag_description(tar, 'c', 'Cria um arquivo tar.').
flag_description(tar, 'x', 'Extrai arquivos de um arquivo tar.').
flag_description(tar, 'v', 'Exibe detalhes durante a operação.').
flag_description(chmod, 'u', 'Altera as permissões do proprietário do arquivo.').
flag_description(chmod, 'g', 'Altera as permissões do grupo do arquivo.').
flag_description(chmod, 'o', 'Altera as permissões de outros usuários.').
flag_description(df, 'h', 'Exibe os tamanhos em formato legível para humanos (e.g., 1K, 234M, 2G).').
flag_description(df, 'T', 'Exibe o tipo de sistema de arquivos.').
flag_description(df, 't', 'Exibe apenas sistemas de arquivos de um determinado tipo.').
flag_description(du, 'h', 'Exibe os tamanhos em formato legível para humanos (e.g., 1K, 234M, 2G).').
flag_description(du, 's', 'Exibe apenas o total de cada argumento.').
flag_description(du, 'c', 'Exibe um total geral no final.').
flag_description(grep, 'i', 'Ignora diferenças entre maiúsculas e minúsculas ao fazer a correspondência de padrões.').
flag_description(grep, 'v', 'Inverte a correspondência, mostrando apenas linhas que não correspondem ao padrão.').
flag_description(grep, 'c', 'Exibe apenas o número de linhas correspondentes, em vez das linhas em si.').

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
    flag_description(Command, Flag, Description),
    write('A flag '), write(Flag), write(' faz: '), write(Description), nl,
    write('Exemplo de uso: '), write(Command), write(' -'), write(Flag), nl.

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
