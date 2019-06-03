FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install \
	software-properties-common \
	openssl \ 
	git \
	locales \
	ant \
	unzip \
	g++ \
	libgdk-pixbuf2.0-dev \
	python-pip \
	cmake \
	libx11-dev \
	libxmu-dev \
	libglu1-mesa-dev \
	libgl2ps-dev \
	libxi-dev \
	libzip-dev \
	libpng-dev \
	libcurl4-gnutls-dev \
	libfontconfig1-dev \
	libsqlite3-dev \
	libglew-dev \
	libssl-dev \
	libgtk-3-dev \
	libglfw3 \
	libglfw3-dev \
	xorg-dev \
	wget \
	ninja-build

WORKDIR /opt/

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
	unzip sdk-tools-linux-4333796.zip && \
	rm -rf sdk-tools-linux-4333796.zip

RUN wget https://digitalocean.cocos2d-x.org/Cocos2D-X/cocos2d-x-3.17.1.zip && \
	unzip cocos2d-x-3.17.1.zip && \
	rm -rf cocos2d-x-3.17.1.zip

RUN apt-get -y remove openjdk-11-* && apt-get -y install openjdk-8-jdk openjdk-8-jre
RUN cd ./tools/bin && \
	yes | ./sdkmanager --licenses && \
	yes | ./sdkmanager --install 'platforms;android-28' && \
	yes | ./sdkmanager --install ndk-bundle && \
	yes | ./sdkmanager --install 'lldb;3.1' 

ENV ANDROID_SDK_ROOT=/opt
ENV NDK_ROOT=/opt/ndk-bundle
ENV COCOS_TEMPLATES_ROOT=/opt/cocos2d-x-3.17.1/templates
ENV COCOS_CONSOLE_ROOT=/opt/cocos2d-x-3.17.1/tools/cocos2d-console/bin
ENV PATH ${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/platform-tools:${NDK_ROOT}:${COCOS_CONSOLE_ROOT}:${PATH}

WORKDIR /workspace

CMD /bin/bash