# janet-neovim-trial-kit

Try out some Janet support in Neovim without interfering with
your existing Neovim setup [1].

![Demo](janet-neovim-trial-kit-linux.png?raw=true "Demo")

## Requirements

* C compiler ([gcc](https://gcc.gnu.org/),
  [clang](https://clang.llvm.org/), etc. invocable via `cc`)
* [git](https://git-scm.com/)
* [janet](https://janet-lang.org)
* [jpm](https://github.com/janet-lang/jpm)
* [nvim](https://neovim.io)
* [spork](https://github.com/janet-lang/spork)

For Windows:

* Ensure `clang.exe` or `gcc.exe` is on your `PATH` (e.g. via: `scoop
  install clang` or `scoop install gcc`) - this is instead of `cc`
  mentioned above.
* Only tested with neovim installed via scoop, YMMV.
* Probably you want to investigate your ["Credential Helper
  Selector"](https://kevinfiol.com/blog/getting-rid-of-the-credential-helper-selector-on-git-for-windows/)
  situation before trying this on Windows.

## What You Get

The Neovim setup provides:

* Basic Janet code handling (e.g. indentation) via
  [janet.vim](https://github.com/janet-lang/janet.vim)
* Syntax highlighting via
  [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  with
  [tree-sitter-janet-simple](https://github.com/sogaiu/tree-sitter-janet-simple)
  support
* REPL interaction via [Conjure](https://github.com/Olical/conjure/)
* Linting via [nvim-lint](https://github.com/mfussenegger/nvim-lint/)
* Contextual awareness via [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context/)
* Syntactic code view and navigation via
  [playground](https://github.com/nvim-treesitter/playground)
* Rainbow delimiters via [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)
* Dark theme via [gruvbox](https://github.com/sogaiu/morhetz/gruvbox)
* (Re)discoverability improvements via [which-key](https://github.com/folke/which-key.nvim)
* Simple plugin manager via [vim-plug](https://github.com/junegunn/vim-plug)

All without having to:

* Manually fetch certain dependencies
* Change your existing Neovim configuration
* Figure out how to configure Neovim for some Janet support

## Initial Setup

Initial invocations:

```
git clone https://github.com/sogaiu/janet-neovim-trial-kit
cd janet-neovim-trial-kit
jpm run neovim
```

The above lines may take some time to complete as there will likely
be multiple git cloning operations and compiling of C code.

The end result should be a started up Neovim.

## Verifying Things Are Working

### Conjure REPL Support

To verify Conjure's REPL support works, first invoke:

```
janet-netrepl
```

in a terminal with the repository's root directory as the current
working directory.  This command is part of `spork` and by default it
starts a janet process listening on port `9365` of localhost
(typically `127.0.0.1`).

Now open a `.janet` file.  This repository contains `sample.janet` for
this purpose.  Once opened, one should see:

```janet
(+ 1 2)

(defn my-fn
  [x]
  (+ x 2))

(my-fn 3)
```

Also visible should be Conjure's HUD indicating a successful
connection.  A message like the following should be visible:

```
# 127.0.0.1:9365 (connected)
```

To evaluate some code, move the cursor somewhere on top of
`(+ 1 2)` and enter `,er`.  The result should be something like
the following in the HUD:

```
# eval (root-form): (+ 1 2)
```

Also, you might see `=> 3` to the right of `(+ 1 2)` in the source
code.  Moving the cursor should cause the HUD and the `=> 3` to
disappear.

Check out `:ConjureSchool` to learn more.

### Playground

Invoking `:TSPlaygroundToggle` should display a tree representation
of the source like this:

```
par_tup_lit [0, 0] - [0, 7]
  sym_lit [0, 1] - [0, 2]
  num_lit [0, 3] - [0, 4]
  num_lit [0, 5] - [0, 6]
par_tup_lit [2, 0] - [4, 10]
  sym_lit [2, 1] - [2, 5]
  sym_lit [2, 6] - [2, 11]
  sqr_tup_lit [3, 2] - [3, 5]
    sym_lit [3, 3] - [3, 4]
  par_tup_lit [4, 2] - [4, 9]
    sym_lit [4, 3] - [4, 4]
    sym_lit [4, 5] - [4, 6]
    num_lit [4, 7] - [4, 8]
par_tup_lit [6, 0] - [6, 9]
  sym_lit [6, 1] - [6, 6]
  num_lit [6, 7] - [6, 8]
```

Invoke `:TSPlaygroundToggle` to get it to go away.

With the plaground showing, once a cursor is in the same buffer,
navigation among the nodes of the tree should cause parts of the
source buffer to be highlighted.  This can be handy for learning about
syntax.

Tracking occurs if the cursor is in the source buffer as well.  That
is, corresponding tree nodes will be highlighted as source is
navigated.

## Typical Use

Start Neovim by:

```
jpm run neovim
```

## Operating Systems with Confirmed Success

* Android via Termux (`clang` as `cc`, `janet` + `jpm` built from source)
* Void Linux
* Windows 10 (though see "Known Issues" below)

## Cleanup

* Removing the cloned directory should remove nearly all traces of
  this program because everything except `$XDG_RUNTIME_DIR` lives
  within the cloned directory.  IIUC, the content of the exception
  (`stdpath("run")`) lives in a temporary directory anyway so it may be
  that one's system will clean it up automatically.

* If you just want a "fresh start", this can be done by issuing `git
  clean -ff .` from the cloned directory. This should remove all
  (non-temporary) files and directories that got added via `jpm run
  neovim`.  Alternatively, just remove the cloned directory and
  reclone to start over.

## Known Issues

* I haven't succeeded in getting Conjure's netrepl support to work on
  Windows.  I'm pretty sure it has something to do with Conjure
  because I've had success using a non-Conjure netrepl setup on
  Windows.

## Footnotes

[1] Various `XDG_*` environment variables are set before starting
`nvim` to influence what is returned by `stdpath`.

