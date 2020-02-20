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

#~ Create a variable and set its value in R
#~ Pass the SEXP from R to Ruby
#~ Call Rf_PrintValue from Ruby
R.evalQuietlyInR("y <- 4.5")
Rlib.Rf_PrintValue(R.evalInR("y"))

#~ Obtain a pointer in Ruby to the data array underlying
#~ the v created in R
R.evalQuietlyInR("v <- c(1.5, 3.4, 4.2)")
puts Rlib.REAL(R.evalInR("v"))
