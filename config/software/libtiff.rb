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

name "libtiff"
default_version "4.0.3"

source :url => "ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.3.tar.gz",
       :md5 => "051c1068e6a0627f461948c365290410"

dependency 'zlib'

relative_path "tiff-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  command "./configure --prefix=#{install_dir}/embedded --with-zlib-prefix=#{install_dir}/embedded", env: env
  command "make -j #{workers}", env: env
  command "make install", env: env
end