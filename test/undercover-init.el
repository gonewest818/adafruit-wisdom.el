;;; undercover-init.el --- setup undercover

(require 'undercover)

(undercover "*.el"
            (:report-file "coverage.json")
            (:send-report nil))

(provide 'undercover-init)

;;; undercover-init.el ends here
