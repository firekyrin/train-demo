var output = function (i) {
	setTimeout(function () {
		console.log(new Date, i);
	}, 1000);
}

for (var i = 0; i < 5; i++) {
	output(i);
}

console.log(new Date, i);
