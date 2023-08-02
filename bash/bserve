while true;
  do echo -e "HTTP/1.1 200 OK\n\n$(iostat)" \
  | nc -l -k -p 8080 -q 1; 
done
