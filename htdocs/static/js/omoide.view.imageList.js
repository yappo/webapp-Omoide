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
			html = html + '<div id="img-' + obj.id + '" class="thumbnail"><img class="thumbnailImage" src="' + Omoide.createImageUrl("s", obj.id, true) + '" /></div>';
		});
		var $html = $(html);
		$html.find(".thumbnailImage").load(function(e) {
			var $this = $(this);
			var paddingLeft = Math.floor((75 - $this.width()) / 2);
			var paddingRight = 75 - paddingLeft - $this.width();
			var paddingTop = Math.floor((75 - $this.height()) / 2);
			var paddingBottom = 75 - paddingTop - $this.height();
			$this.parent().css({
				"width": $this.width()+"px",
				"height": $this.height()+"px",
				"padding-left": paddingLeft+"px",
				"padding-right": paddingRight+"px",
				"padding-top": paddingTop+"px",
				"padding-bottom": paddingBottom+"px"
			});
		});
		var $container = $(this.containerId);
		$container.html($html);
	},

	fixupContainerSize: function(args) {
		var $dom = $(this.containerId);
		$dom.width(args.width)
		$dom.height(args.height)
	},

	_: null
};

})(window);
