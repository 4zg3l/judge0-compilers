# Check for latest version here: https://hub.docker.com/_/buildpack-deps?tab=tags&page=1&name=buster&ordering=last_updated
# This is just a snapshot of buildpack-deps:buster that was last updated on 2019-12-28.
FROM debian:bookworm

RUN apt-get update;\
  apt-get upgrade;\
  apt-get -y install curl build-essential apt-utils\
  ruby=3.1 python=3.11.2-1+b1 octave=7.3.0-2\
  openjdk-17-jdk=17.0.14+7-1~deb12u1\
  fpc=3.2.2+dfsg-20 ghc=9.0.2-4\
  mono-devel=6.8.0.105+dfsg-3.3\
  nodejs=18.19.0+dfsg-6~deb12u2\
  erlang=25.2.3+dfsg-1 elixir=1.14.0.dfsg-2\
  rustc=1.63.0+dfsg1-2 golang=1.19~1 ocaml=4.13.1-4\
  php=8.2+93 default-d-compiler=0.6.5\
  lua5.4=5.4.4-3+deb12u1


# Check for latest version here: https://sourceforge.net/projects/fbc/files/Binaries%20-%20Linux
ENV FBC_VERSIONS \
  1.07.1
RUN set -xe && \
  for VERSION in $FBC_VERSIONS; do \
  curl -fSsL "https://downloads.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC-$VERSION-linux-x86_64.tar.gz" -o /tmp/fbc-$VERSION.tar.gz && \
  mkdir /usr/local/fbc-$VERSION && \
  tar -xf /tmp/fbc-$VERSION.tar.gz -C /usr/local/fbc-$VERSION --strip-components=1 && \
  rm -rf /tmp/*; \
  done


# Check for latest version here: https://github.com/microsoft/TypeScript/releases
ENV TYPESCRIPT_VERSIONS \
  3.7.4
RUN set -xe && \
  curl -fSsL "https://deb.nodesource.com/setup_12.x" | bash - && \
  apt-get update && \
  apt-get install -y --no-install-recommends nodejs && \
  rm -rf /var/lib/apt/lists/* && \
  for VERSION in $TYPESCRIPT_VERSIONS; do \
  npm install -g typescript@$VERSION; \
  done

# Check for latest version here: https://nasm.us
ENV NASM_VERSIONS \
  2.14.02
RUN set -xe && \
  for VERSION in $NASM_VERSIONS; do \
  curl -fSsL "https://www.nasm.us/pub/nasm/releasebuilds/$VERSION/nasm-$VERSION.tar.gz" -o /tmp/nasm-$VERSION.tar.gz && \
  mkdir /tmp/nasm-$VERSION && \
  tar -xf /tmp/nasm-$VERSION.tar.gz -C /tmp/nasm-$VERSION --strip-components=1 && \
  rm /tmp/nasm-$VERSION.tar.gz && \
  cd /tmp/nasm-$VERSION && \
  ./configure \
  --prefix=/usr/local/nasm-$VERSION && \
  make -j$(nproc) nasm ndisasm && \
  make -j$(nproc) strip && \
  make -j$(nproc) install && \
  echo "/usr/local/nasm-$VERSION/bin/nasm -o main.o \$@ && ld main.o" >> /usr/local/nasm-$VERSION/bin/nasmld && \
  chmod +x /usr/local/nasm-$VERSION/bin/nasmld && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: http://gprolog.org/#download
ENV GPROLOG_VERSIONS \
  1.4.5
RUN set -xe && \
  for VERSION in $GPROLOG_VERSIONS; do \
  curl -fSsL "http://gprolog.org/gprolog-$VERSION.tar.gz" -o /tmp/gprolog-$VERSION.tar.gz && \
  mkdir /tmp/gprolog-$VERSION && \
  tar -xf /tmp/gprolog-$VERSION.tar.gz -C /tmp/gprolog-$VERSION --strip-components=1 && \
  rm /tmp/gprolog-$VERSION.tar.gz && \
  cd /tmp/gprolog-$VERSION/src && \
  ./configure \
  --prefix=/usr/local/gprolog-$VERSION && \
  make -j$(nproc) && \
  make -j$(nproc) install-strip && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: http://www.sbcl.org/platform-table.html
ENV SBCL_VERSIONS \
  2.0.0
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends bison re2c && \
  rm -rf /var/lib/apt/lists/* && \
  for VERSION in $SBCL_VERSIONS; do \
  curl -fSsL "https://downloads.sourceforge.net/project/sbcl/sbcl/$VERSION/sbcl-$VERSION-x86-64-linux-binary.tar.bz2" -o /tmp/sbcl-$VERSION.tar.bz2 && \
  mkdir /tmp/sbcl-$VERSION && \
  tar -xf /tmp/sbcl-$VERSION.tar.bz2 -C /tmp/sbcl-$VERSION --strip-components=1 && \
  cd /tmp/sbcl-$VERSION && \
  export INSTALL_ROOT=/usr/local/sbcl-$VERSION && \
  sh install.sh && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: https://ftp.gnu.org/gnu/gnucobol
ENV COBOL_VERSIONS \
  2.2
RUN set -xe && \
  for VERSION in $COBOL_VERSIONS; do \
  curl -fSsL "https://ftp.gnu.org/gnu/gnucobol/gnucobol-$VERSION.tar.xz" -o /tmp/gnucobol-$VERSION.tar.xz && \
  mkdir /tmp/gnucobol-$VERSION && \
  tar -xf /tmp/gnucobol-$VERSION.tar.xz -C /tmp/gnucobol-$VERSION --strip-components=1 && \
  rm /tmp/gnucobol-$VERSION.tar.xz && \
  cd /tmp/gnucobol-$VERSION && \
  ./configure \
  --prefix=/usr/local/gnucobol-$VERSION && \
  make -j$(nproc) && \
  make -j$(nproc) install && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: https://swift.org/download
ENV SWIFT_VERSIONS \
  5.2.3
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends libncurses5 && \
  rm -rf /var/lib/apt/lists/* && \
  for VERSION in $SWIFT_VERSIONS; do \
  curl -fSsL "https://swift.org/builds/swift-$VERSION-release/ubuntu1804/swift-$VERSION-RELEASE/swift-$VERSION-RELEASE-ubuntu18.04.tar.gz" -o /tmp/swift-$VERSION.tar.gz && \
  mkdir /usr/local/swift-$VERSION && \
  tar -xf /tmp/swift-$VERSION.tar.gz -C /usr/local/swift-$VERSION --strip-components=2 && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: https://kotlinlang.org
ENV KOTLIN_VERSIONS \
  1.3.70
RUN set -xe && \
  for VERSION in $KOTLIN_VERSIONS; do \
  curl -fSsL "https://github.com/JetBrains/kotlin/releases/download/v$VERSION/kotlin-compiler-$VERSION.zip" -o /tmp/kotlin-$VERSION.zip && \
  unzip -d /usr/local/kotlin-$VERSION /tmp/kotlin-$VERSION.zip && \
  mv /usr/local/kotlin-$VERSION/kotlinc/* /usr/local/kotlin-$VERSION/ && \
  rm -rf /usr/local/kotlin-$VERSION/kotlinc && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: https://hub.docker.com/_/mono
# I currently use this to add support for Visual Basic.Net but this can be also
# used to support C# language which has been already supported but with manual
# installation of Mono (see above).
ENV MONO_VERSION 6.6.0.161
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends gnupg dirmngr && \
  rm -rf /var/lib/apt/lists/* && \
  export GNUPGHOME="$(mktemp -d)" && \
  gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
  gpg --batch --export --armor 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /etc/apt/trusted.gpg.d/mono.gpg.asc && \
  gpgconf --kill all && \
  rm -rf "$GNUPGHOME" && \
  apt-key list | grep Xamarin && \
  apt-get purge -y --auto-remove gnupg dirmngr && \
  echo "deb http://download.mono-project.com/repo/debian stable-stretch/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official-stable.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends mono-vbnc && \
  rm -rf /var/lib/apt/lists/* /tmp/*

# Check for latest version here: https://packages.debian.org/buster/clang-7
# Used for additional compilers for C, C++ and used for Objective-C.
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends clang-7 gnustep-devel && \
  rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://cloud.r-project.org/src/base
ENV R_VERSIONS \
  4.0.0
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends libpcre2-dev && \
  rm -rf /var/lib/apt/lists/* && \
  for VERSION in $R_VERSIONS; do \
  curl -fSsL "https://cloud.r-project.org/src/base/R-4/R-$VERSION.tar.gz" -o /tmp/r-$VERSION.tar.gz && \
  mkdir /tmp/r-$VERSION && \
  tar -xf /tmp/r-$VERSION.tar.gz -C /tmp/r-$VERSION --strip-components=1 && \
  rm /tmp/r-$VERSION.tar.gz && \
  cd /tmp/r-$VERSION && \
  ./configure \
  --prefix=/usr/local/r-$VERSION && \
  make -j$(nproc) && \
  make -j$(nproc) install && \
  rm -rf /tmp/*; \
  done

# Check for latest version here: https://packages.debian.org/buster/sqlite3
# Used for support of SQLite.
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends sqlite3 && \
  rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://scala-lang.org
ENV SCALA_VERSIONS \
  2.13.2
RUN set -xe && \
  for VERSION in $SCALA_VERSIONS; do \
  curl -fSsL "https://downloads.lightbend.com/scala/$VERSION/scala-$VERSION.tgz" -o /tmp/scala-$VERSION.tgz && \
  mkdir /usr/local/scala-$VERSION && \
  tar -xf /tmp/scala-$VERSION.tgz -C /usr/local/scala-$VERSION --strip-components=1 && \
  rm -rf /tmp/*; \
  done

# Support for Perl came "for free" since it is already installed.

# Check for latest version here: https://github.com/clojure/clojure/releases
ENV CLOJURE_VERSION 1.10.1
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends maven && \
  cd /tmp && \
  git clone https://github.com/clojure/clojure && \
  cd clojure && \
  git checkout clojure-$CLOJURE_VERSION && \
  mvn -Plocal -Dmaven.test.skip=true package && \
  mkdir /usr/local/clojure-$CLOJURE_VERSION && \
  cp clojure.jar /usr/local/clojure-$CLOJURE_VERSION && \
  apt-get remove --purge -y maven && \
  rm -rf /var/lib/apt/lists/* /tmp/*

# Check for latest version here: https://github.com/dotnet/sdk/releases
RUN set -xe && \
  curl -fSsL "https://download.visualstudio.microsoft.com/download/pr/7d4c708b-38db-48b2-8532-9fc8a3ab0e42/23229fd17482119822bd9261b3570d87/dotnet-sdk-3.1.202-linux-x64.tar.gz" -o /tmp/dotnet.tar.gz && \
  mkdir /usr/local/dotnet-sdk && \
  tar -xf /tmp/dotnet.tar.gz -C /usr/local/dotnet-sdk && \
  rm -rf /tmp/*

# Check for latest version here: https://groovy.apache.org/download.html
RUN set -xe && \
  curl -fSsL "https://dl.bintray.com/groovy/maven/apache-groovy-binary-3.0.3.zip" -o /tmp/groovy.zip && \
  unzip /tmp/groovy.zip -d /usr/local && \
  rm -rf /tmp/*

RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  rm -rf /var/lib/apt/lists/* && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends git libcap-dev && \
  rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/ioi/isolate.git /tmp/isolate && \
  cd /tmp/isolate && \
  git checkout ad39cc4d0fbb577fb545910095c9da5ef8fc9a1a && \
  make -j$(nproc) install && \
  rm -rf /tmp/*
ENV BOX_ROOT /var/local/lib/isolate

LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL version="1.4.0"
