if status is-interactive
    # =========================
    # Fish - configurações visuais
    # =========================

    # Comandos como sudo, cd, nano
    set -U fish_color_command b7a0f7

    # Argumentos/parâmetros como nomes de arquivos
    set -U fish_color_param e8e3dc

    # Texto normal/autosuggestion
    set -U fish_color_normal e8e3dc
    set -U fish_color_autosuggestion 66676f

    # Erros
    set -U fish_color_error ef9f9f

    # Operadores como |, &&, ;
    set -U fish_color_operator c6a0f6

    # Strings entre aspas
    set -U fish_color_quote a6d189

    # Caminhos válidos
    set -U fish_color_valid_path e8e3dc

    # Caminhos inválidos
    set -U fish_color_invalid_path ef9f9f

    # Redirecionamentos >, >>, <
    set -U fish_color_redirection e5c890

    # Comentários
    set -U fish_color_comment 5c5c5c

    # Seleção no terminal
    set -U fish_color_selection --background=2a2a2a

    # Histórico pesquisado
    set -U fish_color_search_match --background=2a2a2a

    # =========================
    # Pastas e arquivos no ls
    # =========================

    # Diretórios em roxo/lilás
    # Links em ciano
    # Executáveis em verde pastel
    set -gx LS_COLORS "di=1;35:ln=36:so=35:pi=33:ex=32:bd=33:cd=33:su=31:sg=31:tw=34:ow=34"

    # =========================
    # Atalhos de teclado
    # =========================

    # Ctrl + Backspace: apagar palavra anterior
    bind \b backward-kill-word

    starship init fish | source
end
