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

name "postgis"
default_version "2.1.1"

source :url => "http://download.osgeo.org/postgis/source/postgis-2.1.1.tar.gz",
       :md5 => "4af86a39e2e9dbf10fe894e03c2c7027"


relative_path "#{name}-#{version}"

dependency "gdal"
dependency "postgresql"
dependency "geos"
dependency "proj"
dependency "libxml2"
dependency "json-c"
#TODO: FIgure out why ldrunpath is only setting #{install_dir}/embedded/lib for /raster/rt_pg/rtpostgis-2.1.so
dependency "patchelf"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  patch :source => "postgis-2.1.1.configure.patch"
  command "./autogen.sh", env: env
  command [ "./configure",
            "--prefix=#{install_dir}",
            "--enable-rpath",
            "--with-pgconfig=#{install_dir}/embedded/bin/pg_config",
            "--with-geosconfig=#{install_dir}/embedded/bin/geos-config",
            "--with-gdalconfig=#{install_dir}/bin/gdal-config",
            "--with-projdir=#{install_dir}" ].join(" "), env: env
  command "make -j #{workers}", env: env
  command "make install", env: env
  command ["#{install_dir}/embedded/bin/patchelf",
            "--set-rpath #{install_dir}/lib:#{install_dir}/embedded/lib",
            "#{install_dir}/embedded/lib/postgresql/rtpostgis-2.1.so"].join(" ")
  command ["#{install_dir}/embedded/bin/patchelf",
            "--set-rpath #{install_dir}/lib:#{install_dir}/embedded/lib",
            "#{install_dir}/embedded/lib/postgresql/postgis-2.1.so"].join(" ")

end
