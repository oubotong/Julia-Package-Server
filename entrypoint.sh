#!/bin/bash

git config --global user.email "julia@pkgserver.com" 
git config --global user.name "JuliaPkgServer" 

julia /PkgServer/make_registry.jl
julia /PkgServer/run-server.jl

