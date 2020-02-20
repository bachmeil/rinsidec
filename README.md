## RInsideC

Embed R inside a C program or a program written in any language with a C FFI.

### Example: Hello World in C

This program, written in C, tells R to print a message to the screen:

```
#include <RInsideC.h>

int main() {
	evalQuietlyInR("print('Hello, World')");
}
```

You can find this example in inst/examples/hello.c. There is a Makefile in that directory that will handle the compilation and run the resulting executable:

```
make hello
```

### Example: Passing Data to C

This example pulls data from R into C:

```
#include <RInsideC.h>

int main() {
	evalQuietlyInR("y <- 3");
	evalQuietlyInR("z <- 2.5");
	evalQuietlyInR("print(y*z)");
	evalQuietlyInR("y <- rnorm(10)");
	evalQuietlyInR("print(y)");
	SEXP vec = evalInR("y");
	Rf_PrintValue(vec);
	printf("%f\n", REAL(vec)[4]);
}
```

This example is in inst/examples/passdata.c and can be run with:

```
make pass
```

### Example: Hello World in Ruby

RInsideC doesn't require you to write a C program. You can use it to embed R inside any language with a C FFI. This is the hello.c example given earlier run from Ruby using the ffi gem:

```
require 'ffi'

module R
  extend FFI::Library
  libdir = `Rscript -e \'cat(find.package("RInsideC"))\'`
  ffi_lib "#{libdir}/lib/libRInsideC.so"
  attach_function :evalQuietlyInR, [ :string ], :void
end

R.evalQuietlyInR("print('Hello from R!')")
```

You can find this example in inst/examples/hello.rb. If you have the ffi gem installed, it can be run with:

```
ruby hello.rb
```

### Example: Passing Data to Ruby

This is passdata.c translated to Ruby:

```
require 'ffi'

module R
  extend FFI::Library
  libdir = `Rscript -e \'cat(find.package("RInsideC"))\'`
  ffi_lib "#{libdir}/lib/libRInsideC.so"
  attach_function :evalQuietlyInR, [ :string ], :void
  attach_function :evalInR, [ :string ], :pointer
end

module Rlib
	extend FFI::Library
	ffi_lib "libR.so"
	attach_function :Rf_PrintValue, [ :pointer ], :void
	attach_function :REAL, [ :pointer ], :pointer
end

R.evalQuietlyInR("y <- 4.5")
Rlib.Rf_PrintValue(R.evalInR("y"))

R.evalQuietlyInR("v <- c(1.5, 3.4, 4.2)")
puts Rlib.REAL(R.evalInR("v"))
```

This example is in inst/examples/passdata.rb, and it can be run with:

```
ruby passdata.rb
```

### Authors

Dirk Eddelbuettel and Romain Francois wrote RInside. Lance Bachmeier made minor modifications to expose their interface to C programs.

### License

GPL (>= 2)
