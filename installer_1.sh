#!/bin/bash

# Ensure we are in the correct directory (if running from a different directory)
cd "$(dirname "$0")"

# Start with proton_dependencies.sh
echo "Running proton_dependencies.sh..."
chmod +x proton_dependencies.sh
./proton_dependencies.sh
if [ $? -ne 0 ]; then
    echo "Error running proton_dependencies.sh. Exiting."
    exit 1
fi

# Next, run proton_g_init.sh
echo "Running proton_g_init.sh..."
chmod +x proton_g_init.sh
./proton_g_init.sh
if [ $? -ne 0 ]; then
    echo "Error running proton_g_init.sh. Exiting."
    exit 1
fi

# Finally, run proton_wrapper_replace.sh
echo "Running proton_wrapper_replace.sh..."
chmod +x proton_wrapper_replace.sh
./proton_wrapper_replace.sh
if [ $? -ne 0 ]; then
    echo "Error running proton_wrapper_replace.sh. Exiting."
    exit 1
fi

echo "All scripts ran successfully."
