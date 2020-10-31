const imagemin = require('imagemin');
const imageminPngquant = require('imagemin-pngquant');

(async () => {
	const files = await imagemin(['temp/*.png'], {
		destination: 'temp/optimized',
		plugins: [
			imageminPngquant({
				quality: [0.5, 0.6]
			})
		]
	});
})();