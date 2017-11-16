FROM moiamond/docker-ffmpeg-base-debian:3.2.2
MAINTAINER moiamond@gmail.com


# Install .NET Core dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
        \
# .NET Core dependencies
        libc6 \
        libcurl3 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu52 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        libunwind8 \
        libuuid1 \
        zlib1g \
        curl \
    && rm -rf /var/lib/apt/lists/*


# Install .NET Core
ENV DOTNET_VERSION 2.0.3
ENV DOTNET_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-x64.tar.gz
ENV DOTNET_DOWNLOAD_SHA 4FB483CAE0C6147FBF13C278FE7FC23923B99CD84CF6E5F96F5C8E1971A733AB968B46B00D152F4C14521561387DD28E6E64D07CB7365D43A17430905DA6C1C0

RUN curl -SL $DOTNET_DOWNLOAD_URL --output dotnet.tar.gz \
    && echo "$DOTNET_DOWNLOAD_SHA dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
