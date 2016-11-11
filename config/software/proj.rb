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

name "proj"
default_version "4.8.0"

source :url => "ftp://ftp.remotesensing.org/proj/proj-4.8.0.tar.gz",
       :md5 => "d815838c92a29179298c126effbb1537"


relative_path "#{name}-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  #Fetch additional datagrids
  additional_source = URI("ftp://ftp.remotesensing.org/proj/proj-datumgrid-1.5.zip")

  command "curl #{additional_source.to_s} -O"
  command "unzip #{::File.basename(additional_source.path)} -d #{project_dir}"
  patch source: 'epsg.patch'

  command "./configure --prefix=#{install_dir} --with-zlib-prefix=#{install_dir}/embedded", env: env
  command "make -j #{workers}", env: env
  command "make install", env: env
end
