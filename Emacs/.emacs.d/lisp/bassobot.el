(defconst mrs-invocation "MrsBot")

(defcustom mrs-commands
  (append '((test . mrs-command-test)
	    (info . mrs-command-info)
	    (song . mrs-command-song)
	    (poke . mrs-command-poke)
	    (uptime . mrs-command-uptime)))
  "An associative list of command names and functions to call in the format of:
((command-name-symbol . (lambda () ...))
(command-name-symbol2 . 'funname))"
  :type '(alist :key-type symbol :value-type function))

(defvar mrs-debug t)

(defun mrs-send (sendee lines)
  (let ((nick (car (erc-parse-user sendee))))
    (cond ((stringp lines)
	   (erc-send-message line nil))
	  ((listp lines)
	   (mapc (lambda (line)
		   (erc-send-message line nil))
		 lines)))))

(defun mrs-command-test (data &rest args)
  (message "Data: %S Args: %S" data args))

(defun mrs-command-info (data &rest args)
  (mrs-send (erc-response.sender data)
	    (list "Hello. I am MrsBot.\n"
		  "I am a very simple bot made in Emacs Lisp. The commands I\n"
		  "currently support are:"
		  "info: shows this very beautiful message :3"
		  "song: shows the song I am currently listening too (yes, I"
		  "also use emacs to listen to the music"
		  "poke: displays a message in my mini buffer with your name,"
		  "use this when I've been too afk, you want to call my"
		  "attention or just want to annoy me."
		  "uptime: displays the uptime of my current emacs process")))

(defun mrs-command-song (data &rest args)
  (mrs-send (erc-response.sender data)
	    (list (emms-show))))

(defun mrs-command-uptime (data &rest args)
  (mrs-send (erc-response.sender data)
	    (list (emacs-uptime))))

(defun mrs-command-poke (data &rest args)
  (message "%s %s"
	   (car (erc-parse-user (erc-response.sender data)))
	   (erc-parse-user (erc-response.sender data)))
  (sauron-add-event 'mrsbot
		    5
		    (concat "MASTER! " (car (erc-parse-user (erc-response.sender data))) " Sent you a ping in ERC.")))

(defun mrs-erc-hook (string)
  "Hooks into ERC"
  (let ((pos (string-match mrs-invocation string)))
    (when pos (mrs-run-command (substring string (+ pos (length mrs-invocation))))))
    string)

(defun mrs-run-command (cmd-string)
  (when mrs-debug
    (message "Mrs received command %s" cmd-string))
  (let* ((cmd-parts (split-string (substring-no-properties cmd-string)))
	 (cmd (intern (substring-no-properties (car cmd-parts))))
	 (args (cdr cmd-parts))
	 (data (get-text-property 0 'erc-parsed cmd-string)))
    (message "CMD: %S ARGS %S DATA: %S" cmd args data)
    (let ((cmd (cdr (assoc cmd mrs-commands))))
      (if cmd
	  (cond ((functionp cmd)
		 (apply cmd data args))
		((and (symbolp cmd)
		      (functionp cmd (symbol-value cmd)))
		 (apply (symbol-value cmd) data args))
		(t
		 (message "MrsBot: Someone tried to call %s with %s. (%s)" cmd args data)))
	(message "MrsBot: Unknown command %s" cmd)))))

(add-hook 'erc-insert-pre-hook 'mrs-erc-hook)

(provide 'mrs)
