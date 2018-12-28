FROM reginfell/fastlane

ENV ANDROID_NDK ./android-ndk-linux
ENV ANDROID_NDK_HOME ./android-ndk-linux

RUN apk update
RUN apk add unzip \
	wget
	
RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r18b android-ndk-linux
