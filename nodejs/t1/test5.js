for (var i = 0; i < 5; i++) {
	(function(j){
		setTimeout(function() {
			console.log(new Date, j);
		}, 1000*j);
	})(i);
}

setTimeout(function() {
	console.log(new Date, i);
}, 1000*i);
