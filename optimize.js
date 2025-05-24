import imagemin from 'imagemin';
import imageminWebp from 'imagemin-webp';

(async () => {
	await imagemin(['temp/*.png'], {
		destination: 'temp/optimized',
		plugins: [imageminWebp({ quality: 70 })],
	});

	console.log('Images optimized');
})();

