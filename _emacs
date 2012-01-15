(setq default-directory "~/" )

(setq load-path (cons "~/site-lisp" load-path))

;;;;; Emacs ;;;;;;;;;;;;;;;;;;;;

;; turn off VC mode (performance issue during opening and closing emacs)
(setq vc-handled-backends nil)


(setq tab-always-indent 'complete)

;;; Protocol Buffer Mode   ;;;;;

(require 'protobuf-mode)

;; Printing ;;

(setq printer-name "DOT4_001")


;;;;; AutoInstall

(require 'auto-install)

;;;; Anything

(add-to-list 'load-path "~/site-lisp/anything")
(require 'anything-match-plugin)
(require 'anything-config)

;;;; ParEdit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))

(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))


 ;; Stop SLIME's REPL from grabbing DEL,
          ;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))

;; (setq load-path (cons "~/.emacs.d/elpa" load-path))
;; (load "package")

(global-set-key [(C-wheel-up)] 'previous-buffer)
(global-set-key [(C-wheel-down)] 'next-buffer)

(set-background-color "cornsilk")

;; Path ;;;

(setenv "PATH" (concat "c:/cygwin17/bin;" (getenv "PATH")))
(setq exec-path (cons "c:/cygwin17/bin/" exec-path))

;;;;;; TAGS ;;;;;;

(require 'etags-stack)

;; Nav mode

;(add-to-list 'load-path "~/site-lisp/emacs-nav-20090824b/")
;(require 'nav)


(require 'ido)
(ido-mode t)

;;;;; Tramp stuff
(setq tramp-default-method "ssh")


;; turn off toolbar
(tool-bar-mode 0)

;; Session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)


(require 'bs)
(global-set-key "\C-x\C-b" 'bs-show)

;; common lisp indentation
;(setq lisp-indent-function 'common-lisp-indent-function)

;;;;;; Breadcrumbs bookmarking ;;;;;;;;;;;;;;;;;;;;;

(setq load-path (append (list (expand-file-name "~/elisp")) load-path))
(require 'breadcrumb)

;;
;;  or add the autoloads for the public command functions.
;;
;;  (autoload 'bc-set               "breadcrumb" "Set bookmark in current point."   t)
;;  (autoload 'bc-previous          "breadcrumb" "Go to previous bookmark."         t)
;;  (autoload 'bc-next              "breadcrumb" "Go to next bookmark."             t)
;;  (autoload 'bc-local-previous    "breadcrumb" "Go to previous local bookmark."   t)
;;  (autoload 'bc-local-next        "breadcrumb" "Go to next local bookmark."       t)
;;  (autoload 'bc-goto-current      "breadcrumb" "Go to the current bookmark."      t)
;;  (autoload 'bc-list              "breadcrumb" "List all bookmarks in menu mode." t)
;;  (autoload 'bc-clear             "breadcrumb" "Clear all bookmarks."             t)
;;

;;; Configuration:
;;
;;  Assign the commands to some keys in your .emacs file.
;;
;;  Examples below assign a set of keys to the breadcrumb bookmark functions.
;;  (global-set-key [(shift space)]         'bc-set)            ;; Shift-SPACE for set bookmark
;;  (global-set-key [(meta j)]              'bc-previous)       ;; M-j for jump to previous
;;  (global-set-key [(shift meta j)]        'bc-next)           ;; Shift-M-j for jump to next
;;  (global-set-key [(meta up)]             'bc-local-previous) ;; M-up-arrow for local previous
;;  (global-set-key [(meta down)]           'bc-local-next)     ;; M-down-arrow for local next
;;  (global-set-key [(control c)(j)]        'bc-goto-current)   ;; C-c j for jump to current bookmark
;;  (global-set-key [(control x)(meta j)]   'bc-list)           ;; C-x M-j for the bookmark menu list
;;
;;  Another set of bindings similar to MS Visual Studio bookmark setting.
  (global-set-key [(control f2)]          'bc-set)
  (global-set-key [(f2)]                  'bc-previous)
  (global-set-key [(shift f2)]            'bc-next)
  (global-set-key [(meta f2)]             'bc-list)


;;;;;;;Org ;;;;;;;;;;;;;;;;

(setq load-path (cons "~/site-lisp/org-7.8.02/lisp" load-path))
(setq  load-path  (cons  "~/site-lisp/org-7.8.02/contrib/lisp"  load-path))
(require 'org-install)


(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key  "\C-cc"  'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(global-font-lock-mode 1)                     ; for all buffers

(setq org-agenda-files (file-expand-wildcards "~/projects/org-files/*.org"))

;(setq org-agenda-files '("~/projects/org-files/pj_work.org" "~/projects/org-files/Planner.org"))


(setq org-todo-keywords  '((sequence "TODO" "WORKING" "|" "DONE" "DEFERRED")))

;(when (eq window-system 'w32) 
;  (setq default-frame-alist
;        '(font . "-*-Consolas-normal-r-*-*-12-*-*-*-c-*-iso8859-1")))


(defvar org-journal-file "~/projects/org-files/journal.org"
  "Path to OrgMode journal file.")
(defvar org-journal-date-format "%Y-%m-%d"
  "Date format string for journal headings.")

(defun org-journal-entry ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (switch-to-buffer (find-file org-journal-file))
  (widen)
  (let ((today (format-time-string org-journal-date-format)))
    (beginning-of-buffer)
    (unless (org-goto-local-search-headings today nil t)
      ((lambda () 
         (org-insert-heading)
         (insert today)
         (insert "\n\n  \n"))))
    (beginning-of-buffer)
    (org-show-entry)
    (org-narrow-to-subtree)
    (end-of-buffer)
    (backward-char 2)
    (unless (= (current-column) 2)
      (insert "\n\n  "))))

(global-set-key (kbd "C-c j") 'org-journal-entry)

(setq org-log-done t)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(add-to-list 'org-modules 'org-timer)
(setq org-timer-default-timer 25)

(add-hook 'org-clock-in-hook '(lambda () 
      (if (not org-timer-current-timer) 
      (org-timer-set-timer '(16)))))


;;;;;;;;;;;;;;;; c# ;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))


;; Optionally, define and register a mode-hook function. To do so, use
;; something like this in your .emacs file:

(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (turn-on-auto-revert-mode)
  (setq indent-tabs-mode nil)
  ;(require 'flymake)
  ;(flymake-mode 1)
  ;(require 'yasnippet)
  ;(yas/minor-mode-on)
  ;(require 'rfringe)
  )

(add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)



;;;;;;; Erlang ;;;;;;;;;;;;;;;;;

;; (setq load-path (cons  "C:\\usr\\local\\erl\\lib\\tools-2.5.5\\emacs" load-path))

;; (setq erlang-root-dir "C:\\usr\\local\\erl")
;; (setq exec-path (cons "C:\\usr\\local\\erl\\bin" exec-path))

;; (require 'erlang-start)

;; (add-to-list 'load-path "c:/cygwin17/usr/local/distel/elisp")
;; (require 'distel)
;; (distel-setup)


;; (add-hook 'erlang-mode-hook
;; 	  (lambda ()
;; 	    ;; when starting an Erlang shell in Emacs, default in the node name
;; 	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
;; 	    ;; add Erlang functions to an imenu menu
;; 	    (imenu-add-to-menubar "imenu")))

;; ;; A number of the erlang-extended-mode key bindings are useful in the shell too
;; (defconst distel-shell-keys
;;     '(("\C-\M-i"   erl-complete)
;;       ("\M-?"      erl-complete)	
;;       ("\M-."      erl-find-source-under-point)
;;       ("\M-,"      erl-find-source-unwind) 
;;       ("\M-*"      erl-find-source-unwind) 
;;       )
;;   "Additional keys to bind when in Erlang shell.")

;; (add-hook 'erlang-shell-mode-hook
;; 	  (lambda ()
;; 	    ;; add some Distel bindings to the Erlang shell
;; 	    (dolist (spec distel-shell-keys)
;; 	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;; (defvar inferior-erlang-prompt-timeout t)

;; (setq erl-nodename-cache
;;       (make-symbol
;;        (concat
;;         "emacs@"
;;         ;; Mac OS X uses "name.local" instead of "name", this should work
;;         ;; pretty much anywhere without having to muck with NetInfo
;;         ;; ... but I only tested it on Mac OS X.
;;         (car (split-string (shell-command-to-string "hostname"))))))


;; ;;;;;; Remember ;;;;;;;
;; (require 'org-install)

(add-to-list 'load-path "~/site-lisp/remember-2.0/")
(require 'remember)
(org-remember-insinuate)

(setq org-default-notes-file "~/projects/org-files/refile.org")
(global-set-key (kbd "C-M-r") 'org-remember)
(setq org-remember-store-without-prompt t)

(setq org-remember-templates (quote (("todo" ?t "* TODO %?
  %u
  %a" nil bottom nil)
                                     ("note" ?n "* %?                                        :NOTE:
  %u
  %a" nil bottom nil)
                                     ("phone" ?p "* PHONE %:name - %:company -                :PHONE:
  Contact Info: %a
  %u
  :CLOCK-IN:
  %?" nil bottom nil))))


;;;;;;;;;;;;;;;;;;; Ruby ;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons "~/site-lisp/ruby-mode" load-path))

 (autoload 'ruby-mode "ruby-mode"
     "Mode for editing ruby source files")
 (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 (autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
 (autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))

 (add-hook 'ruby-mode-hook 'turn-on-font-lock)

;;;;;;;;;;;;;;;;;;;;;;;;;; Haskell ;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (load "~/site-lisp/haskell-mode-2.4/haskell-site-file")

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (add-hook 'haskell-mode-hook 
;;    (function
;;     (lambda ()
;;       (setq haskell-program-name "ghci"))))




;;;;;;;;;;;;;;;;;;;;;;;;;; Clojure ;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/site-lisp/clojure-mode")
(require 'clojure-mode)
(setq auto-mode-alist
      (cons '("\\.clj$" . clojure-mode)
            auto-mode-alist))


;; ;; swank-clojure
;(add-to-list 'load-path "~/site-lisp/swank-clojure")

;; (setq swank-clojure-jar-path "~/.clojure/clojure.jar"
;;       swank-clojure-extra-classpaths (list
;; 				      "~/site-lisp/swank-clojure/src/main/clojure"
;; 				      "~/.clojure/clojure-contrib.jar"))

;(require 'swank-clojure-autoload)

;; (add-to-list 'load-path "~/.emacs.d/elpa/slime-repl-20100404")


 ;; (eval-after-load "slime" 
;;    '(progn (slime-setup '(slime-repl))))

;; (add-to-list 'load-path "~/site-lisp/slime")
;; (require 'slime)
;; (slime-setup) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;; lisp  CCL ;;;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/site-lisp/slime")

;; (eval-after-load "slime"
;;   '(progn
;;      (slime-setup '(slime-fancy
;; 		    slime-fancy-inspector
;; 		    slime-asdf
;; 		    slime-indentation
;; 		    slime-fontifying-fu))
;; 					;(slime-autodoc-mode)
;;      (setq slime-complete-symbol*-fancy t)
;;      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
;;      ))
;; (setq inferior-lisp-program  "C:/tools/ccl-1.7/wx86cl.exe")

;; (require 'slime)
;; (slime-setup)


;;;;;;;;;;;;;;;;;;;;;;; Lisp SBCL ;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/site-lisp/slime")

(eval-after-load "slime"
  '(progn
     (slime-setup '(slime-fancy
		    slime-fancy-inspector
		    slime-asdf
		    slime-indentation
		    slime-fontifying-fu))
					;(slime-autodoc-mode)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     ))
(setq inferior-lisp-program  "C:/tools/sbcl_1055/sbcl.exe")

(require 'slime)
(slime-setup)


;;;; Scala ;;;;

(add-to-list 'load-path "~/site-lisp/scala-emacs")
(require 'scala-mode-auto)
	 
(add-hook 'scala-mode-hook
	  '(lambda ()
	     (scala-mode-feature-electric-mode)
	     ))


;;;;;;;;;;;;;;;;;;; Git ;;;;;;;;;;;;;;;
(setq load-path (cons "~/site-lisp/magit-1.0.0" load-path))

(require 'magit)
(defun magit-escape-for-shell (str)
  (if (or (string= str "git")
	  (string-match "^--" str))
      str
    (concat "'" (replace-regexp-in-string "'" "'\\''" str) "'")))


;;;;;;;;;;;;;;;;;;; LFE ;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq load-path (add-to-list 'load-path "c:/cygwin17/usr/local/erlangapps/lfe0.2.1"))
;(require 'lfe-mode)

;;;;; i Buffer ;;;;;;;;;;;;
(require 'ibuffer)
(setq ibuffer-default-sorting-mode 'major-mode)
(setq ibuffer-always-show-last-buffer t)
(setq ibuffer-view-ibuffer t)
;(global-set-key  (kbd "C-x C-b")        'ibuffer-other-window)
(global-set-key  (kbd "C-x C-b")        'ibuffer)


;;;;;;;;;;;;;; code browser, cedet ;;;;;;;;;;;;;;

;(load-file "~/site-lisp/cedet-1.0pre7/common/cedet.el")

;(setq load-path (add-to-list 'load-path "~/site-lisp/ecb-2.40/"))

;(require 'ecb)
;(require 'ecb-autoloads)
;(ecb-byte-compile)


;(setq ecb-source-path (quote ("c:/dev/scripts")))

;; occur in isearch

(defun isearch-occur ()
  "*Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))

(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)


;;;;;;;;;;;;;;;;;;;;; PJ ;;;;;;;;;;;;;;;;;;;;;;;;;;
(find-file "~/projects/org-files/pj_notes.org")
(find-file "~/projects/org-files/pj_work.org")

; try to improve slow performance on windows.
(setq w32-get-true-file-attributes nil)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; start emacs server
(server-start)


;;;;;;;;;;;;;;;;;;;  CL + J ;;;;;;;;;;;;;;;;;;;;;;;;;;

;(defvar cl-user:*jre-home* "C:/Program Files/Java/jre6")
;(defvar cl-user:*jvm-path* "C:/Program Files/Java/jre6/bin/client/jvm.dll")
;(defvar cl-user:*jvm-options* '("-Djava.class.path=C:/libs/lisp-libs/cl+j-0.2/cl_j.jar"))