#!/bin/sh

REPO_PATH=$HOME/working/perl/aoc2025

aoc() {
    docker run --rm -i -v $REPO_PATH:/opt/ perl:advent-of-code \
        carton exec perl /opt/$1/$2/$2-$3.pl
}
