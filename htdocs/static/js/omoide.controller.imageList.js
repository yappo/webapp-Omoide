(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}
if (typeof(window.Omoide.Controller) == 'undefined') {
	window.Omoide.Controller = {};
}


window.Omoide.Controller.ImageList = function(args) {
	if (args === undefined) {
		return this;
	}
	this.containerId = args.containerId;

	return this;
};

window.Omoide.Controller.ImageList.prototype = {
	containerId: null,

	_: null
};

})(window);
