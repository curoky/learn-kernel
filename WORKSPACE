# Copyright (c) 2022-2022 curoky(cccuroky@gmail.com).
#
# This file is part of learn-kernel.
# See https://github.com/curoky/learn-kernel for further info.
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

workspace(name = "com_github_curoky_learn_kernel")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "com_curoky_tame",
    branch = "master",
    remote = "https://github.com/curoky/tame",
)

load("//:build/bazel/recipes.bzl", "pkg_rules_dependencies")

pkg_rules_dependencies()

load("@//:builddir/conan/dependencies.bzl", "load_conan_dependencies")

load_conan_dependencies()

load("@com_github_nelhage_rules_boost//:boost/boost.bzl", "boost_deps")

boost_deps()

load("@hedron_compile_commands//:workspace_setup.bzl", "hedron_compile_commands_setup")

hedron_compile_commands_setup()
