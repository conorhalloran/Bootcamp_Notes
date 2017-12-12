const { log, time, timeEnd } = console

// [1, 4, 6, 7, 11]
// [3, 7, 8, 13, 23, 29, 34]

function merge(arr1, arr2) {
	const newArr = []
	let i1 = 0
	let i2 = 0

	while (i1 < arr1.length && i2 < arr2.length) {
		if (arr1[i1] < arr2[i2]) {
			newArr.push(arr1[i1])
			i1 += 1
		} else {
			newArr.push(arr2[i2])
			i2 += 1
		}
	}

	return newArr.concat(arr1.slice(i1)).concat(arr2.slice(i2))
}

function mergeSort(arr) {
	if (arr.length <= 1) return arr

	let middleIndex = Math.floor(arr.length / 2)
	let leftArr = arr.slice(0, middleIndex)
	let rightArr = arr.slice(middleIndex)

	return merge(mergeSort(leftArr), mergeSort(rightArr))
}

let sortedArr1 = Array.from({ length: 10 })
	.map(() => Math.floor(Math.random() * 50))
	.sort((a, b) => a - b)

let sortedArr2 = Array.from({ length: 10 })
	.map(() => Math.floor(Math.random() * 50))
	.sort((a, b) => a - b)

log('Sorted Arrays:')
log(sortedArr1)
log(sortedArr2)

log('After merge:')
log(merge(sortedArr1, sortedArr2))

// log('unsortedArr:', unsortedArr);
// time('Benchmarking...');
// insertionSort(unsortedArr);
// timeEnd('Benchmarking...');
// log('sortedArr:', unsortedArr);

//bump
