;;; dependencies.el - project specific package dependencies

(use-package lintel
  :quelpa (lintel :fetcher github
                  :repo "gonewest818/lintel"
                  :branch "master"))

(use-package buttercup
  ;;:pin melpa-stable
  :ensure t)

(use-package undercover
  ;;:pin melpa-stable
  :ensure t)

;;; dependencies.el ends here
