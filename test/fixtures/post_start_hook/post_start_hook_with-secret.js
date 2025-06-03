'use strict';

module.exports = function hook(info, cb) {
	if (info.stdin) {
		info.stdin.write('secret: ' + info.getStartupSecret());
	}
	cb(null);
}
