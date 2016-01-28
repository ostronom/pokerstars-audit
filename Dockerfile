FROM haskell:7.10

RUN mkdir -p /app
WORKDIR /app
ADD . /app
COPY bin/* /bin/

RUN apt-get -yqq update \
 && apt-get install -fyqq p7zip-full \
 && cabal update \
 && cabal install --dependencies-only -j4
 && cabal configure \
 && cabal build

EXPOSE 3000
