#include <gtest.h>
extern "C" {
#include "matrix.h"
}


TEST(MatrixTest, DetectSingularity) {
  int isSingular = 0;
  const int nrows = 3, ncols = 3;
  double data[] = {0, 0, 0, 1, 1, 1, 2, 2, 2};

  Matrix *a = matrix_new(nrows, ncols);
  for (int row = 0, col = 0, i = 0; row < nrows; row++) {
    for (int col = 0; col < ncols; col++) {
      matrix_set_value(a, row, col, data[i++]);
    }
  }
  
  isSingular = matrix_test_singular(a);
  EXPECT_TRUE(isSingular);

  matrix_free(&a);
  EXPECT_EQ(a, nullptr);
}


TEST(MatrixTest, DetectNonSingularity) {
  int isSingular = 0;
  const int nrows = 3, ncols = 3;
  const double data[] = {6, 1, 1, 4, -2, 5, 2, 8, 7};

  Matrix *a = matrix_new(nrows, ncols);
  for (int row = 0, col = 0, i = 0; row < nrows; row++) {
    for (int col = 0; col < ncols; col++) {
      matrix_set_value(a, row, col, data[i++]);
    }
  }
  isSingular = matrix_test_singular(a);
  EXPECT_FALSE(isSingular);
  
  matrix_free(&a);
  EXPECT_EQ(a, nullptr);
}


TEST(MatrixTest, DeterminantOfNonSquareMatrix) {
  const int nrows = 2, ncols = 3;
  Matrix *a = matrix_new(nrows, ncols);
  const double data[] = {6, 1, 1, 4, -2, 5};
  double det = 0.0;
  int failure = matrix_get_determinant(a, &det);
  EXPECT_EQ(failure, MATRIX_DATA_NOT_SQUARE);
  
  matrix_free(&a);
  EXPECT_EQ(a, nullptr);
}


TEST(MatrixTest, DeterminantOfEmptyMatrix) {
  const int nrows = 0, ncols = 0;
  double det = 0.0;
  Matrix *a = matrix_new(nrows, ncols);
  int failure = matrix_get_determinant(a, &det);
  EXPECT_EQ(failure, MATRIX_NULL_POINTER);

  matrix_free(&a);
  EXPECT_EQ(a, nullptr);
}


TEST(MatrixTest, DeterminantOfValidMatrix) {
  double det = 0.0;
  const int nrows = 3, ncols = 3;
  const double data[] = {6, 1, 1, 4, -2, 5, 2, 8, 7};
  double target = -306.0;

  Matrix *a = matrix_new(nrows, ncols);
  for (int row = 0, col = 0, i = 0; row < nrows; row++) {
    for (int col = 0; col < ncols; col++) {
      matrix_set_value(a, row, col, data[i++]);
    }
  }

  int failure = matrix_get_determinant(a, &det);
  EXPECT_EQ(failure, MATRIX_NO_ERR);
  EXPECT_DOUBLE_EQ(det, target);

  matrix_free(&a);
  EXPECT_EQ(a, nullptr);
}


TEST(MatrixTest, SolveSimultaneousEquations) {
  const int nrows = 3, ncols = 3;
  double solution[] = {1.0, 5.0, 10.0};
  Matrix *a = matrix_new(nrows, ncols);
  Matrix *b = matrix_new(nrows, 1);
  Matrix *x = matrix_new(nrows, 1);

  const double a_data[] = {6, 1, 1, 4, -2, 5, 2, 8, 7};
  const double b_data[] = {21, 44, 112};

  for (int row = 0, col = 0, i = 0; row < nrows; row++) {
    for (int col = 0; col < ncols; col++) {
      matrix_set_value(a, row, col, a_data[i++]);
    }
  }

  for (int row = 0, col = 0, i = 0; row < nrows; row++) {
    matrix_set_value(b, row, col, b_data[i++]);
  }
  
  int failure = matrix_solve_simeq(a, x, b);
  EXPECT_EQ(failure, MATRIX_NO_ERR);
    
  for (int row = 0, col = 0; row < nrows; row++) {
    double value = matrix_get_value(x, row, col);
    EXPECT_DOUBLE_EQ(value, solution[row]);
  }
  
  matrix_free(&a);
  matrix_free(&b);
  matrix_free(&x);

  EXPECT_EQ(a, nullptr);
  EXPECT_EQ(b, nullptr);
  EXPECT_EQ(x, nullptr);
}


int main(int argc, char* argv[]) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
