const { log, time, timeEnd } = console

function bubbleSort(arr) {
	let hasSwapped = true
	while (hasSwapped) {
		hasSwapped = false
		for (let i = 1, max = arr.length; i < max; i += 1) {
			if (arr[i - 1] > arr[i]) {
				let tmp = arr[i]
				arr[i] = arr[i - 1]
				arr[i - 1] = tmp
				hasSwapped = true
			}
		}
	}
}

function bubbleSortImproved(arr) {
	let hasSwapped = true
	const max = arr.length

	for (let j = max; j > 0 && hasSwapped; j -= 1) {
		hasSwapped = false
		for (let i = 1; i < j; i += 1) {
			if (arr[i - 1] > arr[i]) {
				let tmp = arr[i]
				arr[i] = arr[i - 1]
				arr[i - 1] = tmp
				hasSwapped = true
			}
		}
	}
}

function bubbleSortNaveed(arr) {
	let hasSwapped = true
	let count = 0
	while (hasSwapped) {
		hasSwapped = false
		for (let i = 1, max = arr.length - count; i < max; i += 1) {
			if (arr[i - 1] > arr[i]) {
				let tmp = arr[i]
				arr[i] = arr[i - 1]
				arr[i - 1] = tmp
				hasSwapped = true
			}
		}
		count += 1
	}
}

function insertionSort(arr) {
	let heldCard
	for (let i = 1, max = arr.length; i < max; i += 1) {
		heldCard = arr[i]
		let j
		for (j = i - 1; heldCard < arr[j] && j >= 0; j -= 1) {
			arr[j + 1] = arr[i]
		}
		arr[j + 1] = heldCard
	}
}

let unsortedArr = Array.from({ length: 10000 }).map(() => Math.random() * 10000)

let unsortedArr2 = Array.from(unsortedArr)

let unsortedArr3 = Array.from(unsortedArr)
let unsortedArr4 = Array.from(unsortedArr)

// log('unsortedArr:', unsortedArr);
time('Benchmarking Bubble Sort')
bubbleSort(unsortedArr)
timeEnd('Benchmarking Bubble Sort')
// log('sortedArr:', unsortedArr);

// log('unsortedArr:', unsortedArr);
time('Benchmarking Bubble Sort Improved')
bubbleSortImproved(unsortedArr2)
timeEnd('Benchmarking Bubble Sort Improved')
// log('sortedArr:', unsortedArr);

// log('unsortedArr:', unsortedArr);
time('Benchmarking Bubble Sort Improved 2')
bubbleSortImproved(unsortedArr3)
timeEnd('Benchmarking Bubble Sort Improved 2')
// log('sortedArr:', unsortedArr);

// log('unsortedArr:', unsortedArr);
time('Benchmarking Bubble insertSort')
insertionSort(unsortedArr4)
timeEnd('Benchmarking Bubble insertSort')
// log('sortedArr:', unsortedArr);

//bump
