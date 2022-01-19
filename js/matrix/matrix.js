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


const determinant = (mtrx) => {

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

const getValue = (mtrx, row, col) => {
    const i = getIndex(mtrx, row, col);
    const value = (i >= 0) ? mtrx.data[i] : NaN;
    return value;
}

const setValue = (mtrx, row, col, value) => {
    const i = getIndex(mtrx, row, col)
    if (i >= 0) {
        mtrx.data[i] = value;
    }
}

module.exports = { add, fixColumnIndex, getIndex, getValue, matrix, mul, setValue};
