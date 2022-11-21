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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def dep_tools():
    http_archive(
        name = "hedron_compile_commands",
        urls = [
            "https://github.com/hedronvision/bazel-compile-commands-extractor/archive/refs/heads/main.tar.gz",
        ],
        strip_prefix = "bazel-compile-commands-extractor-main",
    )

    http_archive(
        name = "com_github_nelhage_rules_boost",
        urls = ["https://github.com/nelhage/rules_boost/archive/refs/heads/master.tar.gz"],
        strip_prefix = "rules_boost-master",
    )

    http_archive(
        name = "rules_foreign_cc",
        urls = [
            "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/heads/main.tar.gz",
        ],
        strip_prefix = "rules_foreign_cc-main",
    )

    http_archive(
        name = "rules_pkg",
        urls = [
            "https://github.com/bazelbuild/rules_pkg/archive/refs/heads/main.tar.gz",
        ],
        strip_prefix = "rules_pkg-main",
    )

def dep_libs():
    http_archive(
        name = "com_github_abseil_abseil_cpp",
        urls = ["https://github.com/abseil/abseil-cpp/archive/refs/tags/20220623.1.tar.gz"],
        strip_prefix = "abseil-cpp-20220623.1",
    )

    http_archive(
        name = "com_github_google_double_conversion",
        urls = ["https://github.com/google/double-conversion/archive/refs/tags/v3.2.1.tar.gz"],
        patch_cmds = ["sed -i -e 's/linkopts/includes = [\".\"],linkopts/g' BUILD"],
        strip_prefix = "double-conversion-3.2.1",
    )

    http_archive(
        name = "com_github_google_benchmark",
        urls = [
            "https://github.com/google/benchmark/archive/refs/heads/main.tar.gz",
        ],
        strip_prefix = "benchmark-main",
    )

    http_archive(
        name = "com_github_catchorg_catch2",
        urls = ["https://github.com/catchorg/Catch2/archive/refs/tags/v3.2.0.tar.gz"],
        strip_prefix = "Catch2-3.2.0",
    )

    http_archive(
        name = "com_github_facebook_folly",
        urls = [
            "https://github.com/facebook/folly/archive/refs/tags/v2022.10.31.00.tar.gz",
        ],
        strip_prefix = "folly-2022.10.31.00",
        build_file = "@com_curoky_tame//:recipes/f/folly/default/BUILD",
    )

    http_archive(
        name = "com_github_gflags_gflags",
        urls = [
            "https://github.com/gflags/gflags/archive/refs/heads/master.tar.gz",
        ],
        strip_prefix = "gflags-master",
    )

    http_archive(
        name = "com_github_google_glog",
        urls = ["https://github.com/google/glog/archive/refs/tags/v0.5.0.tar.gz"],
        strip_prefix = "glog-0.5.0",
    )

    http_archive(
        name = "com_github_google_googletest",
        urls = [
            "https://github.com/google/googletest/archive/refs/tags/release-1.12.1.tar.gz",
        ],
        strip_prefix = "googletest-release-1.12.1",
    )

    http_archive(
        name = "com_pagure_libaio",
        urls = [
            "https://pagure.io/libaio/archive/libaio-0.3.113/libaio-libaio-0.3.113.tar.gz",
        ],
        strip_prefix = "libaio-libaio-0.3.113",
        build_file = "@com_curoky_tame//:recipes/l/libaio/default/BUILD",
    )

def pkg_rules_dependencies():
    dep_libs()
    dep_tools()
