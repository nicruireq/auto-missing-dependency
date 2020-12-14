#!/bin/bash
##
## MIT License
## 
## Copyright (c) 2020 Nicolás Ruiz Requejo (https://www.risingedgeonline.com/)

## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
## 
## The above copyright notice and this permission notice shall be included in all
## copies or substantial portions of the Software.
## 
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.
## 
## 
##  @brief  Use: ./auto-missing-dependency path_to_executable_file
##  @author Nicolás Ruiz Requejo
##  @site:  https://www.risingedgeonline.com/
##

if [[ -x $1 ]]; then
    # filter only missing dependencies from executable
    dependencies=($(ldd $1 | grep "not found" | sed 's/=> not found//'))
    echo ${#dependencies[@]}
    # find packages where dependencies are found
    packages=()
    for i in "${dependencies[@]}"; do
        packages+=($(apt-file search $i | cut -d ":" -f 1 | uniq))
    done
    # try to install packages
    for p in "${packages[@]}"; do
        sudo apt install $p
    done 
else
    echo "file is not an executable"
fi
