function add(a, b) {
    return a + b;
}

function mul(a, b) {
    return a * b;
}

function matrix(nrows, ncols) {
    data = Array(nrows * ncols).fill(0);
    obj = {
        nrows: nrows,
        ncols: ncols,
        data: data
    };

    return obj
}

function getIndex(mtrx, row, col) {
    let i = (
        (row < 0) || (row >= mtrx.nrows) ||
        (col < 0) || (col >= mtrx.ncols)
    ) ? NaN : (mtrx.ncols * row) + col
    return i
}

module.exports = { add, getIndex, matrix, mul };