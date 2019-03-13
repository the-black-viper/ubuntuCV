FROM ubuntu:18.04 AS depends

LABEL  maintainer="joshua javier"
#Working build
RUN apt-get update && apt-get install --download-only -y \
      build-essential\
      wget\
      cmake\
      git\
      unzip\
      git\
      libgtk2.0-dev\
      g++\
      pkg-config\
      libavcodec-dev\
      libavformat-dev\
      libswscale-dev\
      libtbb2\
      libtbb-dev\
      libpng-dev\
      libtiff-dev\
      libjpeg-dev

FROM ubuntu:18.04 AS build

LABEL  maintainer="joshua javier"
#Working build
RUN apt-get update

RUN apt-get install -y \
      build-essential\
      wget\
      cmake\
      git\
      unzip\
      git\
      libgtk2.0-dev\
      g++\
      pkg-config\
      libavcodec-dev\
      libavformat-dev\
      libswscale-dev\
      libtbb2\
      libtbb-dev\
      libpng-dev\
      libtiff-dev\
      libjpeg-dev
      
ENV OPENCV_VERSION='4.0.1'

RUN cd /opt && \
  wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
  unzip ${OPENCV_VERSION}.zip && \
  rm -rf ${OPENCV_VERSION}.zip

RUN mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
  cd /opt/opencv-${OPENCV_VERSION}/build && \
  cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_DOCS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_opencv_apps=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_SHARED_LIBS=ON \ 
    -D BUILD_TESTS=OFF \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D FORCE_VTK=OFF \
    -D WITH_FFMPEG=OFF \
    -D WITH_GDAL=OFF \ 
    -D WITH_IPP=OFF \
    -D WITH_OPENEXR=OFF \
    -D WITH_OPENGL=OFF \ 
    -D WITH_QT=OFF\
    -D WITH_TBB=OFF \ 
    -D WITH_XINE=OFF \ 
    -D BUILD_JPEG=ON  \
    -D BUILD_TIFF=ON \
    -D BUILD_PNG=ON \
  .. && \
  make -j4 && \
  make install && \
  rm -rf /opt/opencv-${OPENCV_VERSION}

  RUN ldconfig -v