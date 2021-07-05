package matrix

import (
	"fmt"
)

type matrix struct {
	rows  uint
	cols  uint
	elems []float64
}

func NewMatrix(rows uint, cols uint) *matrix {
	mtrx := &matrix{
		rows:  rows,
		cols:  cols,
		elems: make([]float64, rows*cols),
	}
	return mtrx
}

func GetCol(mtrx *matrix, col uint) []float64 {
	values := make([]float64, mtrx.rows)
	var row uint
	for row = 0; row < mtrx.rows; row++ {
		value := GetItem(mtrx, row, col)
		values[row] = value
	}

	return values
}

func GetColCount(mtrx *matrix) uint {
	return mtrx.cols
}

func GetDiagonalFwd(mtrx *matrix, startCol uint) []float64 {
	values := make([]float64, mtrx.rows)
	var col, row uint

	for row = 0; row < mtrx.rows; row++ {
		col = startCol + row
		if col >= mtrx.cols {
			col = -mtrx.cols
		}
		values[row] = GetItem(mtrx, row, col)
	}

	return values
}

func GetDiagonalRev(mtrx *matrix, startCol uint) []float64 {
	values := make([]float64, mtrx.rows)
	var col, row uint

	for row = 0; row < mtrx.rows; row++ {
		col = startCol - row
		if col < 0 {
			col += mtrx.cols
		}
		values[row] = GetItem(mtrx, row, col)
	}

	return values
}

func GetIndex(mtrx *matrix, row uint, col uint) uint {
	idx := (row * mtrx.rows) + col
	return idx
}

func GetItem(mtrx *matrix, row uint, col uint) float64 {
	idx := GetIndex(mtrx, row, col)

	item := mtrx.elems[idx]

	return item
}

func GetRowCount(mtrx *matrix) uint {
	return mtrx.rows
}

func getSliceProduct(values []float64) float64 {
	var product float64 = 1.0

	for _, value := range values {
		product *= value
	}

	return product
}

func SetItem(mtrx *matrix, row uint, col uint, value float64) {
	idx := GetIndex(mtrx, row, col)
	mtrx.elems[idx] = value
}

func Determinant(mtrx *matrix) (float64, error) {
	var det float64 = 0.0
	var err error

	var col uint
	var product float64

	if mtrx.rows > 0 && mtrx.cols != mtrx.rows {
		err = fmt.Errorf("Cannot calculate determinant of matrix with %d rows and %d columns", mtrx.rows, mtrx.cols)
		return det, err
	}
	
	// Add products of forward diagonals:
	for col = 0; col < mtrx.cols; col++ {
		diag := GetDiagonalFwd(mtrx, col)
		product = getSliceProduct(diag)
		det += product
	}

	// Subtract products of reverse diagonals:
	for col = 0; col < mtrx.cols; col++ {
		diag := GetDiagonalRev(mtrx, col)
		product = getSliceProduct(diag)
		det -= product
	}

	return det, nil
}
