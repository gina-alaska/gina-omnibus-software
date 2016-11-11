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

name "gdal"
default_version "1.10.1"

source :url => "http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz",
       :md5 => "86b2c71a910d826a7fe6ebb43a532fb7"


relative_path "#{name}-#{version}"

dependency "curl"
dependency "geos"
dependency "hdf5"
dependency "hdf4"
dependency "libxml2"
dependency "mrsid" if ENV['MT_MRSID_URL']
dependency "libspatialite"
#dependency "python"
dependency "proj"
dependency "libecwj2"
dependency "perl"
dependency "perl-extutils-makemaker"
dependency "perl-extutils-install"
dependency "giflib"
dependency "libtiff"
dependency "libgeotiff"
dependency "libpng"
dependency "expat"

env = {
  "LDFLAGS"     => "-L#{install_dir}/embedded/lib -L#{install_dir}/lib -I#{install_dir}/include -I#{install_dir}/embedded/include",
  "CFLAGS"      => "-I#{install_dir}/embedded/include -I#{install_dir}/include",
  "CPPFLAGS"    => "-I#{install_dir}/embedded/include -I#{install_dir}/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib:#{install_dir}/lib",
  "PERL5LIB"    => "#{install_dir}/embedded/lib/perl5"
}
# # CFLAGS="-I/opt/mapping_tools_builds/2015.11.04/embedded/include -I/opt/mapping_tools_builds/2015.11.04/include"
#   CFLAGS="-I/opt/mapping_tools_builds/2015.11.04/embedded/include -I/opt/mapping_tools_builds/2015.11.04/include"
# # CPPFLAGS="-I/opt/mapping_tools_builds/2015.11.04/embedded/include -I/opt/mapping_tools_builds/2015.11.04/include"
#   CPPFLAGS="-I/opt/mapping_tools_builds/2015.11.04/embedded/include -I/opt/mapping_tools_builds/2015.11.04/include"
# # LDFLAGS="-L/opt/mapping_tools_builds/2015.11.04/embedded/lib -L/opt/mapping_tools_builds/2015.11.04/lib -I/opt/mapping_tools_builds/2015.11.04/include -I/opt/mapping_tools_builds/2015.11.04/embedded/include"
#   LDFLAGS="-L/opt/mapping_tools_builds/2015.11.04/embedded/lib -L/opt/mapping_tools_builds/2015.11.04/lib -I/opt/mapping_tools_builds/2015.11.04/include -I/opt/mapping_tools_builds/2015.11.04/embedded/include"
# # LD_RUN_PATH="/opt/mapping_tools_builds/2015.11.04/embedded/lib:/opt/mapping_tools_builds/2015.11.04/lib"
#   LD_RUN_PATH="/opt/mapping_tools_builds/2015.11.04/embedded/lib:/opt/mapping_tools_builds/2015.11.04/lib"
# # PERL5LIB="/opt/mapping_tools_builds/2015.11.04/embedded/lib/perl5"
#   PERL5LIB="/opt/mapping_tools_builds/2015.11.04/embedded/lib/perl5"

build do
  # env = with_standard_compiler_flags(with_embedded_path).merge({
  #   "PERL5LIB"    => "#{install_dir}/embedded/lib/perl5",
  #   "LD_RUN_PATH" => "#{install_dir}/embedded/lib:#{install_dir}/lib"
  #   })

  configure = [ "./configure",
            "--prefix=#{install_dir}",
            "--with-ecw=#{install_dir}/embedded",
            "--with-expat=#{install_dir}/embedded",
            "--without-mysql",
            "--with-pg=",
            "--with-ogr",
            "--with-curl=#{install_dir}/embedded/bin/curl-config",
            "--without-libtool",
            "--disable-static",
	          "--with-gif=#{install_dir}/embedded",
            "--with-jpeg=#{install_dir}/embedded",
            "--with-png=#{install_dir}/embedded",
            #"--with-python",
            #"--with-perl",
            "--with-geotiff=internal",
            "--with-libtiff=internal",
            "--with-hdf4=#{install_dir}/embedded",
            "--with-hdf5",
            "--with-sqlite3=#{install_dir}/embedded",
            "--with-spatialite=#{install_dir}/embedded" ]

  configure.push( "--with-mrsid=#{install_dir}/embedded") if ENV['MT_MRSID_URL']

  command configure.join(" "), env: env
  command "make -j #{workers}", env: env
  command "(cd swig/perl && make generate && #{install_dir}/embedded/bin/perl Makefile.PL && make)", env: env
  command "make install", env: env
end
