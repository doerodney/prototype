const add = (a, b) => {
    return a + b;
}

const mul = (a, b) => {
    return a * b;
}

const matrix = (nrows, ncols) => {
    data = Array(nrows * ncols).fill(0);
    obj = {
        nrows: nrows,
        ncols: ncols,
        data: data
    };

    return obj
}

const fixColumnIndex = (i, ncols) => {
    let fixed = i;
    if (i < 0) { 
        fixed = (i + ncols); 
    } else if (i >= ncols) {
        fixed = (i - ncols);        
    }
    return fixed;
}

const getIndex = (mtrx, row, col) => {
    let i = (
        (row < 0) || (row >= mtrx.nrows) ||
        (col < 0) || (col >= mtrx.ncols)
    ) ? NaN : (mtrx.ncols * row) + col
    return i
}

module.exports = { add, fixColumnIndex, getIndex, matrix, mul };
