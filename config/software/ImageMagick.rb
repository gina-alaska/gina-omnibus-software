name "ImageMagick"
default_version "6.9.2-5"

# Sources may be URLs, git locations, or path locations
source url: "http://www.imagemagick.org/download/ImageMagick-#{version}.tar.gz"

version("6.9.2-4") { source md5: "9a8ca2a52a1ec6668b40fd3f02ee8ef0" }
version("6.9.2-5") { source md5: "caa60e6ac24f713d49f527cff2b3a021" }

relative_path "ImageMagick-#{version}"

dependency 'libjpeg'
dependency 'libpng'
dependency 'libtiff'

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded --disable-openmp", env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end

