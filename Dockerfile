FROM rcqls/dyndocker:latest

MAINTAINER "Cqls Team"



RUN mkdir -p /tmp/julia

WORKDIR /tmp/julia

RUN wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.3/julia-0.3.11-linux-x86_64.tar.gz

RUN tar xzvf julia-0.3.11-linux-x86_64.tar.gz \
    && rm julia-0.3.11-linux-x86_64.tar.gz \
    && mv "$(ls -d julia-*)" julia-0.3.11 \
    && mv julia-0.3.11 /

ENV JULIA_DIR /julia-0.3.11

RUN git clone https://github.com/rcqls/jl4rb.git 

WORKDIR /tmp/julia/jl4rb

RUN rake docker

ENV PATH $PATH:/julia-0.3.11/bin

ENV JULIA_PKGDIR /dyndoc-library/julia

RUN rm -fr /tmp/julia

## the dyndoc projects folder

RUN mkdir -p /dyndoc-proj

VOLUME /dyndoc-proj

WORKDIR /dyndoc-proj


## Port exposed by dyn-srv

EXPOSE 7777

## the server to expose

CMD ["/usr/local/bin/dyn-srv"]


## END


