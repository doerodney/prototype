const fizz = 3
const buzz = 5
const fizzbizz = fizz * buzz

for (let i = 0; i < 100; i++) {
    if ((i % fizzbizz) == 0) {
        console.log('fizzbuzz: ' + i)
    } else if ((i % fizz) == 0) {
        console.log('fizz: ' + i)
    } else if ((i % buzz) == 0) {
        console.log('buzz: ' + i)
    }
}