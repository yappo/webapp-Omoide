(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}
if (typeof(window.Omoide.View) == 'undefined') {
	window.Omoide.View = {};
}


window.Omoide.View.ImageList = function(args) {
	if (args === undefined) {
		return this;
	}
	this.containerId = args.containerId;

	return this;
};

window.Omoide.View.ImageList.prototype = {
	containerId: null,

	appendImages: function(list) {
		var $container = $(this.containerId);
		$.each(list, function(i, obj) {
			$container.append($('<div><img src="' + Omoide.createImageUrl("s", obj.id, true) + '" /></div>'));
		});
	},

	_: null
};

})(window);
