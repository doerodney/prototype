# Description
This implements code that solves N-dimensional sets of simultaneous equations, using the traditional AX=B model.  It uses Cramer's Rule to implement the solutions.  As a side benefit, since Cramer's Rule uses matrix determinants, this code exposes a function to get the determinant of an NxN matrix.

This code was used as a test platform for me to learn CMake.  This implements build and unit test execution by CMake.

## How to Build

To appreciate what CMake creates, it is useful to first start with a clean repository.  The `git clean` command removes anything that is not in version control.

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
cmake ../
```

This sets up CMake files in the ./build directory.


To build, do this from the ./build directory:
```
cmake --build .
```

The build artifact(s) will be in the ./build directory.

To run unit tests, from the build directory:
```
cd test
ctest
```

The results of unit tests will be displayed.



