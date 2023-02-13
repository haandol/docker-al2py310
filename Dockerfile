FROM public.ecr.aws/amazonlinux/amazonlinux:2.0.20230119.1
LABEL maintainer "dongkyl <dongkyl@amazon.com>"

RUN yum update -y
RUN yum groupinstall "Development Tools" -y
RUN yum erase openssl-devel -y
RUN yum install openssl11 openssl11-devel  libffi-devel bzip2-devel wget -y

WORKDIR /app
RUN wget https://www.python.org/ftp/python/3.10.10/Python-3.10.10.tgz && tar zxvf Python-3.10.10.tgz

WORKDIR /app/Python-3.10.10
RUN ./configure --enable-optimizations
RUN make -j $(nproc)
RUN make install

WORKDIR /app

CMD [ "python3", "--version" ]

