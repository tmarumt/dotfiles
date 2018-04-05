if [[ `uname -a` =~ Linux && `uname -a` =~ Microsoft ]]; then
  export DISPLAY=localhost:0.0
fi
