(setq load-path
			(append (list
							 (expand-file-name "~/.emacs.d/js2")) load-path))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'package)
  (add-to-list 'package-archives
		'("melpa" . "http://melpa.milkbox.net/packages/") t)

; set to indent with tabs
(setq-default indent-tabs-mode t)
; tabs width is set to two spaces
(setq-default tab-width 2)
; set tab-stop to 2 spaces
(add-hook 'js2-mode-hook
	'(lambda ()
		(setq js2-basic-offset 2)))

(setq backup-directory-alist
	'((".*" . "~/.emacs.trash"))) ; move backups files from current file directory to ~/.emacs.trash
(setq auto-save-file-name-transforms
	'((".*" "~/.emacs.backups" t))) ; move backups files from current file directory to ~/.emacs.trash

;;; js-beautify.el -- http://sethmason.com/2011/04/28/jsbeautify-in-emacs.html

(defgroup js-beautify nil
	"Use jsbeautify to beautify some js"
	:group 'editing)

(defcustom js-beautify-args "--jslint-happy --brace-style=collapse	--indent-with-tabs --space-in-paren	 --keep-array-indentation"
	"Arguments to pass to jsbeautify script"
	:type '(string)
	:group 'js-beautify)

(defcustom js-beautify-path "/usr/local/bin/js-beautify"
	"Path to jsbeautifier javascript file"
	:type '(string)
	:group 'js-beautify)

(defun js-beautify ()
	"Beautify a region of javascript using the code from jsbeautify.org"
	(interactive)
	(let ((orig-point (point)))
		(unless (mark)
			(mark-defun))
		(shell-command-on-region (point)
														 (mark)
														 (concat "python "
																		 js-beautify-path
																		 " --stdin "
																		 js-beautify-args)
														 nil t)
		(goto-char orig-point)))

(provide 'js-beautify)
;;; js-beautify.el ends here

;; Set M-t key to js-beautify
(global-set-key "\M-t" 'js-beautify)

;;; auto-complete mode
(add-to-list 'load-path "~/.emacs.d/auto-complete")
; load default configuration
(require 'auto-complete-config)
(global-auto-complete-mode t)
(auto-complete-mode t)
;;; end auto-complete mode

;;; ternjs
(add-to-list 'load-path "/usr/local/lib/node_modules/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)

(add-hook 'js2-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
	'(progn
		 (require 'tern-auto-complete)
		 (tern-ac-setup)))
;;; ternjs ends here

;;; set ido-mode 
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;;;

;;; Some minor changes to movements
; use M-n to for next-line
(global-set-key "\M-n" 'next-line)
; use M-p for previous-line
(global-set-key "\M-p" 'previous-line)
; use M-l to position buffer at center
(global-set-key "\M-l" 'recenter)
;;; end

;;; enable subword mode on javascript
(add-hook 'js2-mode-hook (lambda () (subword-mode t)))
;;; end

;;; web-mode.el destroys C-c C-v, explicitly binding it here
(add-hook 'web-mode-hook
					(lambda () 
						(global-set-key (kbd "C-c C-v") 'browse-url-of-buffer)))
;;;

;;; web-mode.el
(add-to-list 'load-path "~/.emacs.d/webmode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
; customizations
(defun web-mode-hook()
	"Hooks for Web mode."
	(setq web-mode-markup-indent-offset 2)
	(setq web-mode-code-indent-offset 2)
	(setq web-mode-css-indent-offset 2)
	(setq web-mode-indent-style 2))
(add-hook 'web-mode-hook 'web-mode-hook)
;;; end

;;; code folding
(add-hook 'js2-mode-hook
					(lambda ()
						;; Scan the file for nested code blocks
						(imenu-add-menubar-index)
						;; Activate the folding mode
						(hs-minor-mode t)))
(global-set-key (kbd "C-h") 'hs-hide-block)
(global-set-key (kbd "C-j") 'hs-show-block)
;;; end

;;; yasnippet engine !!!not working
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
; snippet directory
(yas/load-directory "~/.emacs.d/snippets") ;; personal snippets
(add-to-list 'ac-sources 'ac-source-yasnippet)
(yas-reload-all)
; mode hooks
(add-hook 'js2-mode-hook
					'(lambda ()
						 (yas-minor-mode)))
;;; end

;;; undo
(global-set-key (kbd "C-u") 'undo)
;;; end

;;; awesomeness copied in http://blog.deadpansincerity.com/2011/05/setting-up-emacs-as-a-javascript-editing-environment-for-fun-and-profit/
(add-to-list 'load-path "~/.emacs.d/js-comint")
(require 'js-comint)
;; use node as our repl
(setq inferior-js-program-command "node")
(setq inferior-js-mode-hook
			(lambda ()
				;; we likes nice colors
				(ansi-color-for-comint-mode-on)
				;; deal with some prompt nonsense
				(add-to-list
				 'comint-preoutput-filter-functions
				 (lambda (output)
					 (replace-regexp-in-string "\033\\[[0-9]+[A-Z]" "" output)))))
;;; end