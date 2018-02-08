;;; Emacs initialization for isolated package testing
;;
;; Usage: emacs -q -l $project_root/emacs/init.el

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set `user-emacs-directory' to avoid overwriting $HOME/.emacs.d
;; See also: https://debbugs.gnu.org/cgi/bugreport.cgi?bug=15539#66

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq custom-file (concat user-emacs-directory ".emacs-custom.el"))
(when (file-readable-p custom-file) (load custom-file))

;; Configure package
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa"        . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap `use-package' and `quelpa-use-package'
(unless (require 'quelpa nil t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))

(quelpa '(quelpa-use-package
          :fetcher github
          :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)

(load (concat user-emacs-directory "dependencies.el"))
