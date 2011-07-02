(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}
if (typeof(window.Omoide.Controller) == 'undefined') {
	window.Omoide.Controller = {};
}


window.Omoide.Controller.AlbumList = function(args) {
	this.view = new Omoide.View.AlbumList(args);

	if (args === undefined) {
		return this;
	}
	this.containerId = args.containerId;

	return this;
};

window.Omoide.Controller.AlbumList.prototype = {
	view: null,
	containerId: null,

	open: function() {
		this.loadList();
	},

	loadList: function() {
		this.view.appendAlbums([
			{ name: "album name 1" },
			{ name: "album name 2" },
			{ name: "album name 3" },
			{ name: "album name 4" }
		]);

	},


	_: null
};

})(window);
