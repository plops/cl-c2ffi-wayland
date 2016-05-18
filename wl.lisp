
(eval-when (:compile-toplevel) (ql:quickload :cl-autowrap))
(defpackage :wl
  (:use  :cl :autowrap))
(in-package :wl)
(autowrap:c-include "/usr/include/wayland-client.h"
		    :spec-path "/dev/shm/"
		    :exclude-arch ("arm-pc-linux-gnu"
"i386-unknown-freebsd"
"i686-apple-darwin9"
"i686-pc-linux-gnu"
"i686-pc-windows-msvc"
"x86_64-apple-darwin9"
;"x86_64-pc-linux-gnu"
"x86_64-pc-windows-msvc"
"x86_64-unknown-freebsd"
)
		    :exclude-definitions ("asin" "sin" "acos" "cos" "atan" "tan" "exp" "log"
						 "sqrt" "floor" "round"))
