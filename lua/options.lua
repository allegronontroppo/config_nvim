local options = {
    encoding = "utf-8",
    fileencoding = "utf-8",
    clipboard = "unnamedplus",
    completeopt = { "menuone", "noselect" },
    ---------------------------------------------------------------------------
    -- 検索の挙動に関する設定:
    hlsearch = true, -- 検索ハイライト
    ignorecase = true, -- 検索時に大文字小文字を無視 (noignorecase:無視しない)
    smartcase = true, -- 大文字小文字の両方が含まれている場合は大文字小文字を区別
    incsearch = true, -- インクリメンタルサーチ
    inccommand = "split", -- 置換の際、インタラクティブに変更。
    ---------------------------------------------------------------------------
    -- 編集に関する設定:
    tabstop = 8, -- タブの画面上での幅
    softtabstop = 4, -- 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
    shiftwidth = 4, -- 自動インデントでずれる幅
    expandtab = true, -- タブをスペースに展開する/ しない (expandtab:展開する)
    autoindent = true, -- 自動的にインデントする (noautoindent:インデントしない)
    smartindent = true, -- スマートインデント
    backspace = { "indent", "eol", "start" }, -- バックスペースでインデントや改行を削除できるようにする
    wrapscan = true, -- 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
    showmatch = true, -- 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
    wildmenu = true, -- コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
    -- formatoptions+=mM,-- テキスト挿入中の自動折り返しを日本語に対応させる
    ---------------------------------------------------------------------------
    -- GUI固有ではない画面表示の設定:
    title = true, -- タイトルを表示する
    --number = true, -- 行番号を表示 (nonumber:非表示)
    numberwidth = 4, -- 行番号の幅
    relativenumber = false, -- 相対行番号表示
    ruler = true, -- ルーラーを表示 (noruler:非表示)
    list = false, -- タブや改行を表示 (list:表示)
    wrap = false, -- 長い行を折り返して表示 (nowrap:折り返さない)
    laststatus = 2, -- 常にステータス行を表示 (詳細は:he laststatus)
    cmdheight = 2, -- コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
    -- showcmd = 2, -- コマンドをステータス行に表示
    showmode = false, -- モードを表示する
    showtabline = 2, -- タブの行の表示 （2は常に表示）
    conceallevel = 0, -- 非表示シンタックス表示 0はテキスト表示

    splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
    splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
    ---------------------------------------------------------------------------
    -- ファイル操作に関する設定:
    backup = false, -- バックアップファイルを作成しない
    swapfile = false, -- スワップファイルを作成しない
    pumheight = 10, -- ポップアップメニューの最大アイテム数
    undofile = true, -- undoをファイル保存するか？


    mouse = "a",
    termguicolors = true,
    timeoutlen = 300,
    updatetime = 300,
    writebackup = false,
    shell = "zsh",
    backupskip = { "/tmp/*", "/private/tmp/*" },
    cursorline = true,
    signcolumn = "yes",
    winblend = 0,
    wildoptions = "pum",
    pumblend = 5,
    background = "dark",
    scrolloff = 8,
    sidescrolloff = 8,
    guifont = "monospace:h17",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd([[set formatoptions+=mM]])
vim.cmd([[set backspace=indent,eol,start]])

-- eof
