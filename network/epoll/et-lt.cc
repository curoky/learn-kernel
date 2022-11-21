/*
 * Copyright (c) 2022-2022 curoky(cccuroky@gmail.com).
 *
 * This file is part of learn-kernel.
 * See https://github.com/curoky/learn-kernel for further info.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <catch2/catch_test_macros.hpp>
#include <fcntl.h>
#include <folly/ScopeGuard.h>
#include <sys/epoll.h>
#include <unistd.h>

#include <string>

// https://cloud.tencent.com/developer/article/1736793

TEST_CASE("read", "[epoll]") {
  int pipefd[2];
  REQUIRE(pipe2(pipefd, O_NONBLOCK) == 0);
  int pipeForWrite = pipefd[1], pipeForRead = pipefd[0];
  SCOPE_EXIT {
    close(pipefd[0]);
    close(pipefd[1]);
  };

  int epollfd = epoll_create1(0);
  REQUIRE(epollfd > 0);
  SCOPE_EXIT { close(epollfd); };

  epoll_event event, events[5];

  bool isEPOLLET = false;

  event.data.fd = pipeForRead;
  SECTION("LT") { event.events = EPOLLIN; }

  SECTION("ET") {
    isEPOLLET = true;
    event.events = EPOLLIN | EPOLLET;
  }

  REQUIRE(epoll_ctl(epollfd, EPOLL_CTL_ADD, pipeForRead, &event) == 0);
  REQUIRE(epoll_wait(epollfd, events, 5, 10) == 0);

  // write 2 bytes
  REQUIRE(write(pipeForWrite, "ab", 2) == 2);
  REQUIRE(epoll_wait(epollfd, events, 5, 10) == 1);
  REQUIRE(events[0].data.fd == pipeForRead);

  // only read 1 byte
  char buf;
  REQUIRE(read(pipeForRead, &buf, 1) == 1);
  REQUIRE(buf == 'a');

  if (isEPOLLET) {
    REQUIRE(epoll_wait(epollfd, events, 5, 10) == 0);
  } else {
    REQUIRE(epoll_wait(epollfd, events, 5, 10) == 1);

    // read the next 1 byte
    REQUIRE(read(pipeForRead, &buf, 1) == 1);
    REQUIRE(buf == 'b');
    REQUIRE(epoll_wait(epollfd, events, 5, 10) == 0);
  }
  REQUIRE(epoll_wait(epollfd, events, 5, 10) == 0);
}

TEST_CASE("write", "[epoll]") {
  int pipefd[2];
  REQUIRE(pipe2(pipefd, O_NONBLOCK) == 0);
  int pipeForWrite = pipefd[0], pipeForRead = pipefd[1];
  SCOPE_EXIT {
    close(pipefd[0]);
    close(pipefd[1]);
  };

  int epollfd = epoll_create1(0);
  REQUIRE(epollfd > 0);
  SCOPE_EXIT { close(epollfd); };

  epoll_event event, events[5];
  event.data.fd = pipeForWrite;

  bool isEPOLLET = false;
  SECTION("LT") { event.events = EPOLLOUT; }
  SECTION("ET") {
    isEPOLLET = true;
    event.events = EPOLLOUT | EPOLLET;
  }

  char buf = 'a';
  write(pipeForWrite, &buf, 1);
  read(pipeForRead, &buf, 1);
  REQUIRE(buf == 'a');

  REQUIRE(epoll_ctl(epollfd, EPOLL_CTL_ADD, pipeForWrite, &event) == 0);
  // TODO: why pipe fd not trigger event.
  REQUIRE(epoll_wait(epollfd, events, 5, 10) == 0);
}
