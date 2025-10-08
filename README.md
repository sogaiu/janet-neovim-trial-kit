# janet-neovim-trial-kit

The two main purposes of the trial kit are to:

1. Make it easy to experience some Janet support in Neovim without
   having to:

    * Change your existing Neovim configuration
    * Figure out how to configure Neovim for some Janet support
    * Manually fetch certain dependencies

2. Provide [a
   path](https://github.com/sogaiu/janet-editor-and-tooling-info/blob/master/doc/neovim.md)
   to find out about Janet-relevant Neovim plugins.

![Demo](janet-neovim-trial-kit-linux.png?raw=true "Demo")

## Requirements

* C compiler ([gcc](https://gcc.gnu.org/),
  [clang](https://clang.llvm.org/), etc. invocable via `cc`)
* [git](https://git-scm.com/)
* [janet](https://janet-lang.org)
* [nvim](https://neovim.io) - recent version might be necessary (>= 0.10.0)

For Windows:

* Ensure `clang.exe` or `gcc.exe` is on your `PATH` (e.g. via: `scoop
  install clang` or `scoop install gcc`) - this is instead of `cc`
  mentioned above.
* Only tested with neovim installed via scoop, YMMV.
* Probably you want to investigate your ["Credential Helper
  Selector"](https://kevinfiol.com/blog/getting-rid-of-the-credential-helper-selector-on-git-for-windows/)
  situation before trying this on Windows.

## What You Get

The trial kit provides a Janet-specific arrangement as well as some
extra functionality.

### Janet-Specific

* mREPL interaction via [Conjure](https://github.com/Olical/conjure/) and
  [Grapple](https://github.com/pyrmont/grapple)
* Basic Janet code handling (e.g. indentation) via
  [janet.vim](https://github.com/janet-lang/janet.vim)
* Syntax highlighting via
  [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  with
  [tree-sitter-janet-simple](https://github.com/sogaiu/tree-sitter-janet-simple)
  support

### Extras

* Rainbow delimiters via [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)
* Dark theme via [gruvbox](https://github.com/sogaiu/morhetz/gruvbox)
* Simple plugin manager via [vim-plug](https://github.com/junegunn/vim-plug)

## Initial Setup

Initial invocations:

```
git clone https://github.com/sogaiu/janet-neovim-trial-kit --branch mrepl
cd janet-neovim-trial-kit
janet jntk
```

The above lines may take some time to complete as there will likely
be multiple git cloning operations and compiling of C code.

The end result should be a started up Neovim.

## Verifying Things Are Working

### Basic Evaluation

Open a `.janet` file.  This repository contains `sample.janet` for
this purpose.  Once opened, one should see:

```janet
(+ 1 2)

(defn my-fn
  [x]
  (+ x 2))

(my-fn 3)
```

Also visible should be Conjure's HUD indicating a successful
connection.  A message somewhat like the following should be visible:

```
# Sponsored by @chad
======= info =======
Connected to Grapple v1.0.0-dev running Janet v1.40.0 as session 11
```

To evaluate some code, move the cursor somewhere on top of
`(+ 1 2)` and enter `,er`.  The result should be something like
the following in the HUD:

```
====== input =======
(+ 1 2)
====== result ======
3
```

Moving the cursor should cause the HUD disappear.

Check out `:ConjureSchool` to learn more.

## Typical Use

Start Neovim by:

```
janet jntk
```

To specify a file to edit (e.g. `sample.janet`) on startup:

```
janet jntk sample.janet
```

## Operating Systems with Confirmed Success

* Android via Termux (`clang` as `cc`, `janet` built from source)
* Void Linux
* Windows 10

## Cleanup

* Removing the cloned directory should remove nearly all traces of
  this program because everything except `$XDG_RUNTIME_DIR` lives
  within the cloned directory.  IIUC, the content of the exception
  (`stdpath("run")`) lives in a temporary directory anyway so it may be
  that one's system will clean it up automatically.

* If you just want a "fresh start", this can be done by issuing `git
  clean -ff .` from the cloned directory. This should remove all
  (non-temporary) files and directories that got added via `janet
  jntk`.  Alternatively, just remove the cloned directory and
  reclone to start over.

## Caveats

Various `XDG_*` environment variables are set before starting `nvim`
to influence what is returned by `stdpath`.

## Credits

Thanks to authors of various bits, but also the following folks for
efforts specifically regarding this project:

* amano-kenji
* bakpakin
* Grazfather
* harryvederci
* Olical
* pyrmont

