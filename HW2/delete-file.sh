#!/bin/bash
find . -maxdepth 1 -type f -exec grep -w "error" {} \; -delete
