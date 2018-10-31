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
ENV DOTNET_VERSION 2.1.5

RUN curl -SL --output dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-x64.tar.gz \
    && dotnet_sha512='d815c79fd868d2642898ddc09c890a90c4ab26ef8999046581d7e3912bb06ec97ce6637ce8bf0ceb9deb773daab1c0cd93e336992c885a4fd7550d6686d4dbf4' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
