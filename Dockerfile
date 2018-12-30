FROM reginfell/fastlane

ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux
ENV ANDROID_TARGET_SDK="android-27" \
	ANDROID_BUILD_TOOLS="build-tools-27.0.3"

RUN apk update
RUN apk add unzip \
	wget
	
RUN apk add cmake \
	make \
	ninja \
	ninja-build
	
RUN cmake -version
RUN ninja --version

RUN cd /opt && \
	wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r18b android-ndk-linux

# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# Android Cmake
RUN wget -q https://dl.google.com/android/repository/cmake-3.6.3155560-linux-x86_64.zip -O android-cmake.zip
RUN unzip -q android-cmake.zip -d ${ANDROID_HOME}/cmake
ENV PATH ${PATH}:${ANDROID_HOME}/cmake/bin
RUN chmod u+x ${ANDROID_HOME}/cmake/bin/ -R

RUN /bin/bash ${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh \
-arch=arm \
--platform=android-27 \
--install-dir=${ANDROID_HOME} \

COPY toolchain.cmake .
