(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}
if (typeof(window.Omoide.Controller) == 'undefined') {
	window.Omoide.Controller = {};
}


window.Omoide.Controller.MainContainer = function(args) {
	if (args === undefined) {
		return this;
	}
	this.containerId = args.containerId;

	return this;
};

window.Omoide.Controller.MainContainer.prototype = {
	containerId: null,

	_: null
};

})(window);
