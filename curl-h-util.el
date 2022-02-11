;; some utilities to help create cffi commonlisp definitions for the libcurl
;; particularly for long lists of enum. Assume that we are running a live slime session.

;; lets work on the very long list of CURLoption enum's
;; we can assume that we copied the appropriate definitions from curl.h into curl-h.lisp
;; and blocked them with #| and |# to comment them out, so to speak


;;;;;; some elisp tutorial stuff
(defun yct-simplified-beginning-of-buffer ()
  "Move point to beginning of the buffer;
   leave mark at previous position"
  (interactive)
  (push-mark)
  (goto-char (point-min)))
  
(defun yct-mark-whole-buffer ()
  "Put point at beginning and mark at end of buffer.
     You probably should not use this function in Lisp programs;
     it is usually a mistake for a Lisp function to use any subroutine
     that uses or sets the mark."
  (interactive)
  (push-mark (point))
  (push-mark (point-max) nil t)
  (goto-char (point-min)))


(defun yct-append-to-buffer (buffer start end)
  "Append to specified buffer the text of the region.
It is inserted into that buffer before its point.

When calling from a program, give three arguments:
BUFFER (or buffer name), START and END.
START and END specify the portion of the current buffer to be copied."
  (interactive
   (list (read-buffer "Append to buffer: " (other-buffer
                                            (current-buffer) t))
         (region-beginning) (region-end)))
  (let ((oldbuf (current-buffer)))
    (save-excursion
      (let* ((append-to (get-buffer-create buffer))
             (windows (get-buffer-window-list append-to t t))
             point)
        (set-buffer append-to)
        (setq point (point))
        (barf-if-buffer-read-only)
        (insert-buffer-substring oldbuf start end)
        (dolist (window windows)
          (when (= (window-point window) point)
            (set-window-point window (point))))))))
