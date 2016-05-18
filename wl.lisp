
(eval-when (:compile-toplevel)
  (ql:quickload :cl-autowrap)
  (ql:quickload :rutilsx))
(defpackage :wl
  (:use  :cl #:autowrap #:rutil #:rutilsx
	 #:rutilsx.threading))
(in-package :wl)
(named-readtables:in-readtable rutils-readtable)

(eval-always
 (defpar *spec-path* (merge-pathnames
		      "stage/cl-c2ffi-wayland/"
		      (user-homedir-pathname))))

(autowrap:c-include "/usr/include/wayland-client.h"
		    :spec-path *spec-path*
		    :exclude-arch ("arm-pc-linux-gnu"
				   "i386-unknown-freebsd"
				   "i686-apple-darwin9"
				   "i686-pc-linux-gnu"
				   "i686-pc-windows-msvc"
				   "x86_64-apple-darwin9"
					;"x86_64-pc-linux-gnu"
				   "x86_64-pc-windows-msvc"
				   "x86_64-unknown-freebsd")
		    :exclude-sources ("/usr/include/inttypes.h"
				      "/usr/include/math.h"
				      "/usr/include/stdarg.h"
				      "/usr/include/stddef.h"
				      "/usr/include/stdint.h"
				      "/usr/include/sys/types.h")
		    ;:exclude-definitions
		    #+nil ("asin" "sin"  "acos" "cos"
			    "atan" "tan" "exp" "log"
			    "sqrt" "floor" "round"))

(autowrap:c-include "/usr/include/wayland-client-protocol.h"
		    :spec-path *spec-path*
		    :exclude-arch ("arm-pc-linux-gnu"
				   "i386-unknown-freebsd"
				   "i686-apple-darwin9"
				   "i686-pc-linux-gnu"
				   "i686-pc-windows-msvc"
				   "x86_64-apple-darwin9"
					;"x86_64-pc-linux-gnu"
				   "x86_64-pc-windows-msvc"
				   "x86_64-unknown-freebsd")
		    :exclude-definitions
		    ("asin" "sin"  "acos" "cos"
			    "atan" "tan" "exp" "log"
			    "sqrt" "floor" "round"))

#+ni
(cffi:use-foreign-library "libwayland-client.so")

#+nil
(defpar *display* (wl-display-connect (cffi:null-pointer)))

#+nil
(defpar *registry* (wl-display-))
