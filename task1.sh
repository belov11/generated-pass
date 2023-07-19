#!/bin/bash

checknum() {
  if [[ "$1" > 1 && "$1" =~ ^[0-9]+$ ]]; then
    return "$1"
  else
    echo "`date` : Check the entered value" >> error.log
    echo `tail -1 error.log`
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
case "$1" in
  -l)
      length_pass="$2"
      checknum "$length_pass"
    shift
    ;;
  -n)
    num_pass="$2"
    checknum "$num_pass"
    shift
    ;;
  *)
    echo "`date` : $1 is not an option" >> error.log
    echo `tail -1 error.log`
    exit 1
    ;;
esac
shift
done

if [[ -n "$length_pass" ]]; then  
  echo ""
else
  length_pass=10
fi
if [[ -n "$num_pass" ]]; then
  echo ""
else
  num_pass=5
fi

cat /dev/urandom | tr -dc '[:alpha:][:digit:]' | fold -w "$length_pass" | head -n "$num_pass" > pass.txt
echo "Pass generated successfully"
