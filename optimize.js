const imagemin = require('imagemin');
const imageminPngquant = require('imagemin-pngquant');

// Taken from https://coderrocketfuel.com/article/compress-a-png-image-size-by-up-to-75-percent-with-node-js
(async () => {
	const files = await imagemin(['temp/*.png'], {
		destination: 'temp/optimized',
		plugins: [
			imageminPngquant({
				quality: [0.7, 1.0]
			})
		]
	});
})();