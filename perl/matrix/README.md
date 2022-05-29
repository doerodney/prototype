# Description
This includes working prototypes that solve an NxN system of simultaneous equations.  The implementations include an object-oriented approach, as one might convert into C++ or Python, and a function-based approach, as one might use as a starting point for a C, Go, or Python implementation.

The method used to solve the systems is good old Cramer's Rule.  It's simple, and simplicity is good.  Gauss-Jordan elimination might be faster, but the simplicity of Cramer's Rule is compelling and I have no go-fast requirement.

I implemented this ~~as a prototype for a future machine vision system that will likely need to solve simultaneous equations~~ because the inflight entertainment on my flight from RDU to SEA was not available.

## Object-Oriented Approach
This implementation includes these files:

| File      | Description                                |
|-----------|--------------------------------------------|
| Matrix.pm | A perl module that uses blessed references |
| Matrix.t  | A test suite                               |
| test.pl   | A simple script used to test/debug         |

These files were hacked on a flight with zero available references.  Might be weird.

## Function-Based Approach
This implementation includes these files:

| File    | Description                                           |
|---------|-------------------------------------------------------|
| Mtrx.pm | A perl module that uses functions and no O-O anything |
| Mtrx.t  | A test suite                                          |
| tst.pl  | A simple script used to test/debug                    |

