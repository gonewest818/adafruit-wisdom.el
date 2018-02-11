;;; dependencies.el - project specific package dependencies

(use-package elisp-lint
  :quelpa (elisp-lint :fetcher github
                      :repo "gonewest818/elisp-lint"
                      :branch "modernization"))

(use-package buttercup
  ;;:pin melpa-stable
  :ensure t)

(use-package undercover
  ;;:pin melpa-stable
  :ensure t)

;;; dependencies.el ends here
