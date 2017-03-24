const tasks = [];

for (var i = 0; i < 5; i++) {
	((j) => {
		tasks.push(new Promise((resolve) => {
			setTimeout(() => {
				console.log(new Date, j);
				resolve();
			}, 1000*j);
		}));
	})(i);
}

Promise.all(tasks).then(() => {
	setTimeout(() => {
		console.log(new Date, i);
	}, 1000);
});
