const { log, time, timeEnd } = console

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

let unsortedArr = Array.from({ length: 10 }).map(() => Math.floor(Math.random() * 100))

log('unsortedArr:', unsortedArr)
time('Benchmarking...')
insertionSort(unsortedArr)
timeEnd('Benchmarking...')
log('sortedArr:', unsortedArr)
