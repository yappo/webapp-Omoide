(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}
if (typeof(window.Omoide.View) == 'undefined') {
	window.Omoide.View = {};
}


window.Omoide.View.AlbumList = function(args) {
	if (args === undefined) {
		return this;
	}
	this.containerId = args.containerId;

	return this;
};

window.Omoide.View.AlbumList.prototype = {
	containerId: null,

	appendAlbums: function(list) {
		var html = "";
		$.each(list, function(i, obj) {
			html = html + '<div class="thumbnail">' + obj.name + '</div>';
		});
		var $container = $(this.containerId);
		$container.html(html);
	},

	fixupContainerSize: function(args) {
		var $dom = $(this.containerId);
		$dom.width(args.width)
		$dom.height(args.height)
	},

	_: null
};

})(window);
