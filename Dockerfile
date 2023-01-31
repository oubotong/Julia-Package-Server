FROM julia:1.8.3

WORKDIR /PkgServer

# COPY cache /PkgServer/cache
# COPY data /PkgServer/data
# COPY local-registry.git /PkgServer/local-registry.git
# COPY ./run-server.jl /PkgServer
COPY . /PkgServer

RUN apt-get update \
&&  apt-get install -y git \
&&  useradd julia \
&&  mkdir -p /home/julia \
&&  chown -R julia:julia /home/julia

USER julia

RUN git config --global user.email "julia@pkgserver.com" \
&&  git config --global user.name "JuliaPkgServer" \
&&  julia -e 'using Pkg; Pkg.add("LocalPackageServer"); Pkg.add("LocalRegistry"); Pkg.instantiate()'

EXPOSE 8000
ENV LOCAL_PKG_SERVER_OFFLINE=1
ENTRYPOINT ["/bin/bash", "/PkgServer/entrypoint.sh"]

