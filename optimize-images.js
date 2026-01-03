import imagemin from 'imagemin';
import imageminWebp from 'imagemin-webp';
import imageminPngquant from 'imagemin-pngquant';

(async () => {
	await imagemin(['temp/*.png'], {
		destination: 'temp/optimized',
		plugins: [imageminWebp({ quality: 70 })],
	});

	await imagemin(['temp/*.png'], {
		destination: 'temp/optimized',
		plugins: [
			imageminPngquant({
				quality: [0.7, 1.0],
			}),
		],
	});

	console.log('Images optimized');
})();
