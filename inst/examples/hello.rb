#~ Hello World in Ruby
#~ Printing is done by R, not Ruby
require 'ffi'

module R
  extend FFI::Library
  libdir = `Rscript -e \'cat(find.package("RInsideC"))\'`
  ffi_lib "#{libdir}/lib/libRInsideC.so"
  attach_function :evalQuietlyInR, [ :string ], :void
end

R.evalQuietlyInR("print('Hello from R!')")
