# How to build

The `git clean` command is your friend.  It removes anything that is not in version control.

This tells you what will happen:
```
git clean -d -f --dry-run
```

This implements the clean process: 
```
git clean -d -f
```

To build, start with a clean source tree.

From the project root, do this once:
```
cd ./build
cmake ../src
```

This sets up CMake files in the ./build directory.


To build, do this from the ./build directory:
```
cmake --build .
```

The build artifact(s) will be in the ./build directory.

