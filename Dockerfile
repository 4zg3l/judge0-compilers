FROM buildpack-deps:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install apt-utils -y

# Install GCC 11 & 12 (C)
RUN apt-get install -y --no-install-recommends gcc-11=11.3.0-12 gcc-12=12.2.0-14+deb12u1

# Install ruby 3.1 (Ruby)
RUN apt-get install -y --no-install-recommends ruby3.1=3.1.2-7+deb12u1

# Install python3.11 maybe use python3.11-full=3.11.2-6+deb12u6 (Python)
RUN apt-get install -y --no-install-recommends python3.11=3.11.2-6+deb12u6

# Install GNU Octave 7.3 (Matlab)
RUN apt-get install -y --no-install-recommends octave=7.3.0-2 octave-symbolic=3.0.1-2

# Install OpenJDK 17 (Java)
RUN apt-get install -y --no-install-recommends openjdk-17-jdk=17.0.15+6-1~deb12u1

# Install Bash (Bash)
RUN apt-get install -y --no-install-recommends bash=5.2.15-2+b8

# Install fpc (Pascal)
RUN apt-get install -y --no-install-recommends fpc-3.2.2=3.2.2+dfsg-20

# Install ghc (Haskell)
RUN apt-get install -y --no-install-recommends ghc=9.0.2-4

# Install mono (Mono)
RUN apt-get install -y --no-install-recommends mono-complete=6.8.0.105+dfsg-3.3

# Install nodejs (javascript)
RUN apt-get install -y --no-install-recommends nodejs=18.19.0+dfsg-6~deb12u2 npm=9.2.0~ds1-1

# Install Erlang
RUN apt-get install -y --no-install-recommends erlang=1:25.2.3+dfsg-1+deb12u1

# Install elixir
RUN apt-get install -y --no-install-recommends elixir=1.14.0.dfsg-2

# Install rust Look into rustup
RUN apt-get install -y --no-install-recommends rustc=1.63.0+dfsg1-2

# Install golang
RUN apt-get install -y --no-install-recommends golang-go=2:1.19~1

# Check for latest version here: https://sourceforge.net/projects/fbc/files/Binaries%20-%20Linux
# BASIC
RUN set -xe && \
  wget https://sourceforge.net/projects/fbc/files/FreeBASIC-1.10.1/Binaries-Linux/FreeBASIC-1.10.1-ubuntu-22.04-x86_64.tar.gz/download &&\
  mv ./download /tmp/fbc.tar.gz &&\
  mkdir /usr/local/fbc && \
  tar -xf /tmp/fbc.tar.gz -C /usr/local/fbc --strip-components=1 && \
  rm -rf /tmp/*

# Install ocaml
RUN apt-get install -y --no-install-recommends ocaml=4.13.1-4

# Install php
RUN apt-get install -y --no-install-recommends php=2:8.2+93

# Install D (dlang) v2
RUN apt-get install -y --no-install-recommends gdc=4:12.2.0-3

# Install lua5.4
RUN apt-get install -y --no-install-recommends lua5.4=5.4.4-3+deb12u1

# Install typescript
RUN apt-get install -y --no-install-recommends ts-node=10.9.1+~cs8.8.29-1

# Install Assembly (nasm)
RUN apt-get install -y --no-install-recommends nasm=2.16.01-1

# Install prolog
RUN apt-get install -y --no-install-recommends gprolog=1.4.5.0-3

# Install Common Lisp
RUN apt-get install -y --no-install-recommends sbcl=2:2.2.9-1

# COBOL
RUN apt-get install -y --no-install-recommends gnucobol3=3.1.2-5+b1

# Check for latest version here: https://swift.org/download
# Swift 6.1.2
RUN apt-get install -y --no-install-recommends \
  binutils-gold \
  gcc \
  git \
  libcurl4-openssl-dev \
  libedit-dev \
  libicu-dev \
  libncurses-dev \
  libpython3-dev \
  libsqlite3-dev \
  libxml2-dev \
  pkg-config \
  tzdata \
  uuid-dev &&\
  curl -fSsL "https://download.swift.org/swift-6.1.2-release/debian12/swift-6.1.2-RELEASE/swift-6.1.2-RELEASE-debian12.tar.gz" -o /tmp/swift-6.1.2.tar.gz && \
  mkdir /usr/local/swift-6.1.2 &&\
  tar -xf /tmp/swift-6.1.2.tar.gz -C /usr/local/ --strip-components=2 &&\
  rm -rf /tmp/*

# Kotlin
RUN apt-get install -y --no-install-recommends kotlin=1.3.31+ds1-1

# Check for latest version here: https://hub.docker.com/_/mono
# I currently use this to add support for Visual Basic.Net but this can be also
# used to support C# language which has been already supported but with manual
# installation of Mono (see above).
#ENV MONO_VERSION 6.6.0.161
#RUN set -xe && \
#  apt-get update && \
#  apt-get install -y --no-install-recommends gnupg dirmngr && \
#  rm -rf /var/lib/apt/lists/* && \
#  export GNUPGHOME="$(mktemp -d)" && \
#  gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
#  gpg --batch --export --armor 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /etc/apt/trusted.gpg.d/mono.gpg.asc && \
#  gpgconf --kill all && \
#  rm -rf "$GNUPGHOME" && \
#  apt-key list | grep Xamarin && \
#  apt-get purge -y --auto-remove gnupg dirmngr && \
#  echo "deb http://download.mono-project.com/repo/debian stable-stretch/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official-stable.list && \
#  apt-get update && \
#  apt-get install -y --no-install-recommends mono-vbnc && \
#  rm -rf /var/lib/apt/lists/* /tmp/*
#
## Check for latest version here: https://packages.debian.org/buster/clang-7
# Used for additional compilers for C, C++ and used for Objective-C.


# Clang-17 gets installed with swift
#RUN set -xe && \
#  apt-get update && \
#  apt-get install -y --no-install-recommends clang-7 gnustep-devel && \
#  rm -rf /var/lib/apt/lists/*

# R lang
RUN apt-get install -y --no-install-recommends r-base=4.2.2.20221110-2

# Check for latest version here: https://packages.debian.org/bookworm/sqlite3
# Used for support of SQLite.
RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends sqlite3=3.40.1-2+deb12u1 && \
  rm -rf /var/lib/apt/lists/*

# Check for latest version here: https://scala-lang.org
RUN printf "y\n" > /tmp/installer.txt &&\
  curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs && ./cs setup < /tmp/installer.txt &&\
  rm ./cs && rm -rf /tmp/* && echo 'export PATH="$PATH:~/.local/share/coursier/bin"' >> ~/.bashrc


# Support for Perl came "for free" since it is already installed.

# Clojure
RUN apt-get update && apt-get install -y --no-install-recommends clojure=1.11.1-2

# dotnet 9
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb &&\
  dpkg -i packages-microsoft-prod.deb &&\
  rm packages-microsoft-prod.deb && \
  apt-get update && \
  apt-get install -y dotnet-sdk-9.0

# Check for latest version here: https://groovy.apache.org/download.html
RUN set -xe && \
  curl -fSsL "https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-binary-4.0.27.zip" -o /tmp/groovy.zip && \
  unzip /tmp/groovy.zip -d /usr/local && \
  rm -rf /tmp/*

RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends locales=2.36-9+deb12u10 && \
  rm -rf /var/lib/apt/lists/* && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN set -xe && \
  apt-get update && \
  apt-get install -y --no-install-recommends git=1:2.39.5-0+deb12u2 libcap-dev=1:2.66-4+deb12u1 && \
  rm -rf /var/lib/apt/lists/* && \
  echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/isolate.asc] http://www.ucw.cz/isolate/debian/ bookworm-isolate main' >> /etc/apt/sources.list &&\
  curl https://www.ucw.cz/isolate/debian/signing-key.asc >/etc/apt/keyrings/isolate.asc &&\
  apt-get update && apt-get install isolate

# I didn't want to redo every layer so I put this at the end
RUN apt-get install -y --no-install-recommends ruby-dev=1:3.1


ENV BOX_ROOT /var/local/lib/isolate

LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL version="1.4.0"
