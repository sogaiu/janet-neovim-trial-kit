(declare-project
  :name "janet-neovim-trial-kit"
  :description "A Way to Try Neovim with Janet Support"
  :url "https://github.com/sogaiu/janet-neovim-trial-kit"
  :repo "git+https://github.com/sogaiu/janet-neovim-trial-kit")

(def proj-dir (os/cwd))

(put (dyn :rules) "test" nil)
(task "test" []
  (print "Sorry, no tests here, try `jpm tasks`."))

(defn ensure-bin
  [name]
  (try
    (zero? (let [f (file/temp)
                 r (os/execute ["which" name]
                               :px
                               {:out f})]
             (file/close f)
             r))
    ([e]
      (eprintf "%s does not appear to be on PATH" name)
      false)))

(defn ensure-win-bin
  [name]
  (try
    (zero? (let [f (file/temp)
                 r (os/execute ["where" name]
                               :px
                               {:out f})]
             (file/close f)
             r))
    ([e]
      (eprintf "%s does not appear to be on PATH" name)
      false)))

(defn get-version
  [cmd ver-peg]
  (try
    (let [f (file/temp)
          r (os/execute cmd
                        :px
                        {:out f})]
      (when (not (zero? r))
        (file/close f)
        (errorf "Non-zero exit code: %s" r))
      #
      (file/seek f :set 0)
      (def version-line (file/read f :line))
      (file/close f)
      (def version
        (-?>> (peg/match ver-peg version-line)
              first
              string/trimr))
      #
      version)
    ([e]
      (eprintf "Failed to determine version via %s" cmd)
      false)))

(defn get-major-version
  [ver-str]
  (-?>> (peg/match ~(sequence (capture :d+)) ver-str)
        first
        scan-number))

# XXX: intent is to modify what neovim's stdpath returns
#      see :h standard-path and ;h base-directories
(defn isolate
  []
  (def root-dir (os/cwd))
  (os/setenv "XDG_CONFIG_HOME" (string root-dir "/config"))
  (os/setenv "XDG_DATA_HOME" (string root-dir "/data"))
  #(os/setenv "XDG_RUNTIME_DIR" (string root-dir "/runtime"))
  (os/setenv "XDG_STATE_HOME" (string root-dir "/state"))
  (os/setenv "XDG_CACHE_HOME" (string root-dir "/cache"))
  (os/setenv "XDG_LOG_FILE" (string root-dir "/log")))

(task "setup" []
  (isolate)
  # verify nvim exists and its version is sufficient
  (if (= :windows (os/which))
    (when (not (ensure-win-bin "nvim.exe"))
      (eprintf "Failed to find nvim.exe on PATH\n")
      (os/exit 1))
    (when (not (ensure-bin "nvim"))
      (eprintf "Failed to find nvim on PATH\n")
      (os/exit 1)))
  (def version
    (get-version ["nvim" "--version"]
                 ~(sequence "NVIM v"
                            (capture (some (choice :d "."))))))
  (when (not version)
    (eprintf "Failed to determine nvim version\n")
    (os/exit 1))
  # ensure appropriate c compiler available
  (if (= :windows (os/which))
    (when (and (not (ensure-win-bin "gcc.exe"))
               (not (ensure-win-bin "clang.exe")))
      (eprintf "Failed to find gcc.exe or clang.exe on PATH\n")
      (os/exit 1))
    (when (not (ensure-bin "cc"))
      (eprintf "Failed to find C compiler (cc) on PATH\n")
      (os/exit 1)))
  # install plugins
  (print "Installing plugins...")
  (os/execute ["nvim"
               "-es"
               "-u" "install.vim"
               "-c" "PlugInstall"
               "-c" "quit"]
              :px))

(task "neovim" ["setup"]
  (isolate)
  (os/execute ["nvim"] :px))

