# Linux Development Container for mixlib-shellout
# Build: docker build -f dev/Dockerfile.linux -t mixlib-shellout-dev-linux .
# Run: docker run -it -v $(pwd):/workspace mixlib-shellout-dev-linux

FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    autoconf \
    bison \
    libyaml-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Ruby 3.1
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN rbenv install 3.1.6 && rbenv global 3.1.6

# Install bundler
RUN gem install bundler --no-document

# Set working directory
WORKDIR /workspace

CMD ["/bin/bash"]