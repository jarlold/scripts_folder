#!/bin/bash
# Use LD_PRELOAD to overwrite a function in a dynamically linked binary.

HELP_TEXT="\n
This script uses LD_PRELOAD to overwrite a function in a dynamically linked C binary.\n
This can be super useful for cracking/reverse-engineering challenges.\n
It can also be used to jump to a specific function by overwriting the\n
'void __uClibc_main(void *main, int argc, char** argv)' function in LibC.\n
\n
USAGE: overwrite_c_func [C FILE FOR FUNCTION] [BINARY FILE]\n
EXAMPLE: overwrite_c_func ./custom_strcmp.c ./crack_me\n
\n
In edition to being able to use your own files. This script is equipped to let you\n
compile and use pre-made overwrite files from Github:\n
\n
TIMESKEW    - Slow or speed up the clock of a program.\n
  USAGE: TIMESKEW='200 1' overwrite_c_func TIMESKEW ./program\n
\n
OPENSSLHOOK - Dump SSL socket data to ./hooklog.bin. \n
  USAGE: overwrite_c_func OPENSSLHOOK ./program; strings hooklog.bin\n
\n
PATHMAP     - Re-route absolute path values.\n
  USAGE: PATH_MAPPING='/path/og:/path/new' overwrite_c_func PATHMAP ./program\n
\n
FAKETIME    - Change the system date and time for a specific program.\n
  USAGE: WIP currently must be manually compiled\n
\n
"


# Check if the user is just trying to get the help text
if [[ $1 == '--help' ]] | [[ $1 == '-h' ]]; then
    echo -e $HELP_TEXT
    exit
fi

# Check if the user is trying to use one of our pre-loaded override.c files
PREMADE_OVERRIDES=("TIMESKEW", "OPENSSLHOOK", "PATHMAP", "FAKETIME")
PREMADE_OVERRIDE=false

if [[ $(echo ${PREMADE_OVERRIDES[@]} | grep -o $1 | wc -w) == 0 ]]; then # hello, this is the jank departement
    # If they aren't using one of ours, copy their custom one over.
    echo "Copying custom file to /tmp/override.c"
    cp $1 /tmp/override.c
else 
    echo "Using premade override file..."
    PREMADE_OVERRIDE=$1
fi

# These are some fun overwrite files you can use. This will download them from their github source, so consider that
# their credits.
# Also this might break if they change repo names or move or something.
# Also case statements are ugly so this is an if statement
if [[ $PREMADE_OVERRIDE == "TIMESKEW" ]]; then
    curl -s https://raw.githubusercontent.com/id01/timeskew/tweaked/override.c > /tmp/override.c
    echo "Pre-made module TIMESKEW loaded, examples uses:"
    echo "TIMESKEW="200 1" overwrite_c_func ./override.c 'sleep 120' # Goes speedy fast"
    echo "TIMESKEW="1 200" overwrite_c_func ./override.c 'sleep 120' # Goes slothy slow"
elif [[ $PREMADE_OVERRIDE == "OPENSSLHOOK" ]]; then
    curl -s https://raw.githubusercontent.com/sebcat/openssl-hook/master/hook.c | tail -n +2 > /tmp/override.c
    echo "When you're done dumping, use strings to read the .bin file created in this directory."
elif [[ $PREMADE_OVERRIDE == "PATHMAP" ]]; then
    curl -s https://raw.githubusercontent.com/fritzw/ld-preload-open/master/path-mapping.c| grep -v "#define _GNU_SOURCE" > /tmp/override.c 
    echo "Explain how to use path-mapping here..."
elif [[ $PREMADE_OVERRIDE == "FAKETIME" ]]; then
    echo "https://github.com/wolfcw/libfaketime"
    echo "You'll have to compile and load this one yourself, sorry :/"
fi


echo "Compiling custom shared object..."
gcc -D _GNU_SOURCE /tmp/override.c -o /tmp/preload.so -fPIC -shared -ldl

echo "Launching binary with custom shared object loaded..."
LD_PRELOAD="/tmp/preload.so" $2







