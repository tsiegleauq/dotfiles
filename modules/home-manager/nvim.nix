{
  config,
  lib,
  ...
}: {
  options.nvim.enable = lib.mkEnableOption "enables nvim home-manager module";

  config = lib.mkIf config.nvim.enable {
    programs.neovim = {
      enable = true;
      extraConfig = ''
        set number relativenumber
        set tabstop=4       " number of visual spaces per TAB
        set softtabstop=4   " number of spaces in tab when editing
        set shiftwidth=4    " number of spaces to use for autoindent
        set expandtab       " tabs are space
        set autoindent
        set copyindent      " copy indent from the previous line
        set clipboard=unnamedplus

        " Move lines up and down with Shift + Up/Down
        nnoremap <S-Up> :m-2<CR>
        nnoremap <S-Down> :m+<CR>
        inoremap <S-Up> <Esc>:m-2<CR>
        inoremap <S-Down> <Esc>:m+<CR>
      '';
    };
  };
}
