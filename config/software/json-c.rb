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

name "json-c"
default_version "0.11"

source :url => "http://s3.amazonaws.com/json-c_releases/releases/json-c-0.11.tar.gz",
       :md5 => "aa02367d2f7a830bf1e3376f77881e98"


relative_path "#{name}-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  command [ "./configure",
            "--prefix=#{install_dir}/embedded"].join(" "), env: env
  command "make", env: env
  command "make install", env: env
end
