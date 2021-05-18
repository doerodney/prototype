function sum(a, b) {
    return a + b;
}


function Matrix(nrows, ncols) {
    this.nrows = nrows
    this.ncols = ncols
    this.data = Array(nrows * ncols).fill(0)

    this.getIndex = function(row, col) {
        let i = (
                    (row < 0) || (row >= this.nrows) ||
                    (col < 0) || (col >= this.ncols)
                ) ? NaN : (this.ncols * row) + col
        return i
    }

    this.setValue = function(row, col, value) {
        let i = this.getIndex(row, col)
        if (!isNaN(i)) {
            this.data[i] = value
        }
    }

    this.getValue = function(row, col) {
        let value = NaN
        let i = this.getIndex(row, col)
        if (!isNaN(i)) {
            value = this.data[i]
        }
        return value
    }
}

const nrows = 3
const ncols = 3
let row = 0
let col = 0

let mtrx = new Matrix(nrows, ncols)
for (row = 0; row < nrows; row++) {
    for (col = 0; col < ncols; col++) {
        mtrx.setValue(row, col, (row * 10) + col)
    }
}

for (let row = 0; row < nrows; row++) {
    for (let col = 0; col < ncols; col++) {
        console.log(`(${row}, ${col}) = ${mtrx.getValue(row, col)}`)
    }
}

function getDeterminant(mtrx) {
    let row = 0
    let col = 0
    let val = 0

    let nrows = mtrx.nrows
    let ncols = mtrx.ncols

    let nAddedCols = ncols == 2 ? 0 : ncols - 1

    // Create a new matrix for column augmentation:
    augMtrx = new Matrix(nrows, ncols + nAddedCols)

    // Copy the original matrix content into the augmented matrix:
    for (row = 0; row < nrows; row++) {
        for (col = 0; col < ncols; col++) {
            val = mtrx.getValue(row, col)
            augMtrx.setValue(row, col, val)
        }
    }
    
    // Copy the left columns from the original matrix into the augmented:
    for (let addedCol = 0; addedCol < nAddedCols; addedCol++) {
        for (col = 0; col < (ncols - 1); col++) {
            for (row = 0; row < nrows; row++) {
                val = mtrx.getValue(row, col)
                augMtrx.setValue(ncols + addedCol, col, value)
            }
        }
    }

    // Get the sum of left side diagonals:
    let leftSum = 0
    let diagProduct = 0

    for (col = 0; col < ncols; col++) {
        // Gather diagonal content in an array:
        diag = Array(nrows)
        for (rows = 0; rows < nrows; row++) {
            diag[row] = mtrx.getValue(row, col + row)
        }

        // Get the product of the values in the diag array:
        diagProduct = reduce(diag, (a, b) => a * b, 1)
        leftSum += diagProduct
    }

    // Get the sum of the right side diagonals:
    let rightSum = 0;
    for (col = ncols + nAddedCols; col >= ncols; col--) {
        // Gather diagonal content in an array:
        diag = Array(nrows)
        for (rows = 0; rows < nrows; row++) {
            diag[row] = mtrx.getValue(row, col - row)
        }
        diagProduct = reduce(diag, (a,b) => a * b, 1)
    }

    det = leftSum - rightSum
}

function reduce(array, combine, start) {
    let current = start
    for (let element of array) {}
        current = combine(current, element)
    }
    return current
}


module.exports = sum