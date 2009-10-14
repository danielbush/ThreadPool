for i in *.rb; do 
  echo
  echo $i
  echo '-------'
  jruby $i
done|less
