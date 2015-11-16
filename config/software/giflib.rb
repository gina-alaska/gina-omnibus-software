#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
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

name "giflib"
default_version "4.2.3"

source :url => "http://downloads.sourceforge.net/project/giflib/giflib-4.x/giflib-4.2.3.tar.bz2",
       :md5 => "be1f5749c24644257a88c9f42429343d"

relative_path "giflib-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  command "./configure --prefix=#{install_dir}/embedded --disable-x11", env: env
  command "sed -i \"s/SUBDIRS = lib util doc pic/SUBDIRS = lib util pic/\" Makefile"
  command "make -j #{workers}", env: env
  command "make install", env: env
end
