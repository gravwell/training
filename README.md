# Gravwell Training Repository

This repository contains the LaTeX source for the Gravwell training book, as well as Dockerfiles to build the container images used in the lab sections. Please refer to the [releases page](https://github.com/gravwell/training/releases) for pre-built PDFs of the training book.

## Pre-reqs:

You'll need a basic LaTeX setup:

	apt-get install texlive-* latexmk

If you intend to build the Docker images too, you'll also need to have [Go](https://go.dev) installed, as we compile some utilities in the process.

## Building

To build just the PDF:

	make master.pdf

To build the whole tarball with Docker images and all:

	GOPATH=~/go LICENSE=/path/to/gravwell-license make dist

NOTE: You will need a training license in order to build the complete set of containers.

(If you need to build for a specific older version of Gravwell, set the VERSION variable when running `make dist`.)

