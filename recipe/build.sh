mkdir build
cd build

if [ "$(uname)" == "Darwin" ]; then
  OPENCL_LIBRARIES=""
  HAVE_CLOCK_GETTIME=0
else  # linux for now
  OPENCL_LIBRARIES="-L${PREFIX}/lib;OpenCL"
  HAVE_CLOCK_GETTIME=1
fi

cmake \
  -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
  -D POCL_INSTALL_ICD_VENDORDIR="${PREFIX}/etc/OpenCL/vendors" \
  -D LLVM_CONFIG="${PREFIX}/bin/llvm-config" \
  -D HAVE_CLOCK_GETTIME="${HAVE_CLOCK_GETTIME}" \
  -D KERNELLIB_HOST_CPU_VARIANTS=distro \
  -D OPENCL_LIBRARIES="${OPENCL_LIBRARIES}" \
  -D EXTRA_HOST_LD_FLAGS="-Wl,--as-needed" \
  ..

make -j 8
make install