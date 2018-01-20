#! /bin/bash
brew install openssl libuv cmake zlib
git clone https://github.com/uWebSockets/uWebSockets 
cd uWebSockets
git checkout e94b6e1
patch CMakeLists.txt < ../cmakepatch.txt
mkdir build
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig 
cd build
cmake ..

CMAKE_OPTIONS=''
if [ $(uname) = 'Darwin' ]; then
    CMAKE_OPTIONS='-DOPENSSL_ROOT_DIR=/usr/local/opt/openssl'
fi

cmake "$CMAKE_OPTIONS" ..
make 
sudo make install
cd ../../
sudo rm -r uWebSockets
