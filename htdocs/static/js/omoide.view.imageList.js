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
		var html = "";
		$.each(list, function(i, obj) {
			html = html + '<div><img src="' + Omoide.createImageUrl("s", obj.id, true) + '" /></div>';
		});
		var $container = $(this.containerId);
		$container.html(html);
	},

	_: null
};

})(window);
