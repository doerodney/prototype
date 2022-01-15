const { add, getIndex, matrix, mul }  = require("./matrix.js");

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

test('getIndex', () => {
  m = matrix(3,3);
  expect(getIndex(m, 0, 0)).toBe(0);
  expect(getIndex(m, 2, 2)).toBe(8);
})