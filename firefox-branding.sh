#!/bin/sh
# firefox-branding.sh

bail()
{
  echo $1 >&2
  exit 1
}

installed="false"
version=""


# Verify iceweasel is installed

ORIG_IFS=$IFS
EOL="
"
IFS=$EOL

for line in `dpkg -s iceweasel 2>/dev/null | grep -e "Status:" -e "Version:"`; do
  IFS=$ORIG_IFS

  out=`echo "$line" | grep -e "Status:" | grep -e "installed"`
  if [ -n "$out" ]; then
    installed="true"
  fi

  out=`echo "$line" | grep -e "Version:" | cut  -d ":" -f 2`
  if [ -n "$out" ]; then
    version=`echo $out | cut -d "-" -f 1`
  fi

  IFS=$EOL
done

IFS=$ORIG_IFS

if [ $installed = "true" ]; then
  echo "Iceweasel version $version installed"
else
  bail "Iceweasel not installed"
fi

