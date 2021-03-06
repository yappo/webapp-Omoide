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
	this.albumListContainer = args.albumListContainer;
	this.imageListContainer = args.imageListContainer;

	this.fixupContainerSize();

	var self = this;
	$(window).resize(function() {
		self.onResize();
	});

	return this;
};

window.Omoide.Controller.MainContainer.prototype = {
	albumListContainer: null,
	imageListContainer: null,
	containerId: null,
	onResizeTimeoutId: null,

	onResize: function() {
		if (this.onResizeTimeoutId !== null) {
			clearTimeout(this.onResizeTimeoutId);
			this.onResizeTimeoutId = null;
		}
		var self = this;
		this.onResizeTimeoutId = setTimeout(function() {
			self.fixupContainerSize();
		}, 50);
	},

	fixupContainerSize: function() {
		var widthPadding = 4;

		var $window = $(window);
		var $header = $("#header");
		var $footer = $("#footer");
		var height = $window.height() - $header.height() - $footer.height() - 8;

		var wwidth = $window.width();
		var albumWidth, imageWidth;
		if (wwidth < 650) {
			albumWidth = 150;
			imageWidth = 400;
		} else if (wwidth < 700) {
			imageWidth = 550;
			albumWidth = wwidth - imageWidth - widthPadding;
		} else {
			albumWidth = 200;
			imageWidth = wwidth - albumWidth - widthPadding;
		}

		var $dom = $(this.containerId);
		$dom.width(albumWidth + imageWidth + widthPadding);

		this.albumListContainer.view.fixupContainerSize({
			width: albumWidth,
			height: height
		});
		this.imageListContainer.view.fixupContainerSize({
			width: imageWidth,
			height: height
		});
	},


	_: null
};

})(window);
