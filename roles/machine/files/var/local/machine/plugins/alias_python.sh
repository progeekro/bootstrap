#!/usr/bin/env bash

####################
### Python extra ###
####################

# Python Twine
alias twineTest='twine upload --repository pypitest $(pwd)/dist/*'
alias buildPyWheel='python3 setup.py bdist_wheel'

# Nifty extras
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias pypath='python -c "import sys; print sys.path" | tr "," "\n" | grep -v "egg"'
alias pycclean='find . -name "*.pyc" -exec rm {} \; && find . -name "__pycache__" -exec rm -rf {} \;'