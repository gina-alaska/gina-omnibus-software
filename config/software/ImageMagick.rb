#
# Copyright:: Copyright (c) University of Alaska Fairbanks
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "ImageMagick"
default_version "6.9.2-6"


# Sources may be URLs, git locations, or path locations
source url: "http://www.imagemagick.org/download/ImageMagick-#{version}.tar.gz"

version("6.9.2-4") { source md5: "9a8ca2a52a1ec6668b40fd3f02ee8ef0" }
version("6.9.2-6") { source md5: "7c88eeb52892efa6c412f4ebc06afc9c" }

relative_path "ImageMagick-#{version}"

dependency 'libjpeg'
dependency 'libpng'
dependency 'libtiff'
dependency 'giflib'

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded --disable-openmp", env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
