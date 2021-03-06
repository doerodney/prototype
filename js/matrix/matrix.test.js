const { add, fixColumnIndex, getIndex, getValue, matrix, mul, setValue }  = require("./matrix.js");

test('add 1 + 2 to equal 3', () => {
    expect(add(1, 2)).toBe(3);
});

test('mul 2 * 4 to equal 8', () => {
  expect(mul(2,4)).toBe(8);
});

test('matrix creation', () => {
  m = matrix(3, 4);
  expect(m.nrows).toBe(3);
  expect(m.ncols).toBe(4);
  expect(m.data.length).toBe(12);
});

test('determinant', () => {
  mtrx = matrix(2, 2)
  setValue(mtrx, 0, 0, 5);
  setValue(mtrx, 0, 1, 2);
  setValue(mtrx, 1, 0, 4);
  setValue(mtrx, 1, 1, 2);


})


test('getIndex', () => {
  m = matrix(3,3);
  expect(getIndex(m, 0, 0)).toBe(0);
  expect(getIndex(m, 2, 2)).toBe(8);
})

test('set and get matrix values', () => {
  mtrx = matrix(2,2);
  setValue(mtrx, 0, 0, 5);
  setValue(mtrx, 0, 1, 2);
  setValue(mtrx, 1, 0, 4);
  setValue(mtrx, 1, 1, 2);

  expect(getValue(mtrx, 0, 0)).toBe(5);
  expect(getValue(mtrx, 0, 1)).toBe(2);
  expect(getValue(mtrx, 1, 0)).toBe(4);
  expect(getValue(mtrx, 1, 1)).toBe(2);
})

test('fix column index', () => {
  const ncols = 3;
  expect(fixColumnIndex(0, ncols)).toBe(0);
  expect(fixColumnIndex(1, ncols)).toBe(1);
  expect(fixColumnIndex(2, ncols)).toBe(2);
  expect(fixColumnIndex(3, ncols)).toBe(0);
  expect(fixColumnIndex(4, ncols)).toBe(1);

  expect(fixColumnIndex(-3, ncols)).toBe(0);
  expect(fixColumnIndex(-2, ncols)).toBe(1);
  expect(fixColumnIndex(-1, ncols)).toBe(2);
});
