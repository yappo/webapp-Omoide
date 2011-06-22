(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}
if (typeof(window.Omoide.Controller) == 'undefined') {
	window.Omoide.Controller = {};
}


window.Omoide.Controller.ImageList = function(args) {
	this.view = new Omoide.View.ImageList(args);

	if (args === undefined) {
		return this;
	}
	this.containerId = args.containerId;

	return this;
};

window.Omoide.Controller.ImageList.prototype = {
	view: null,
	containerId: null,

	open: function() {
		this.loadList();
	},

	loadList: function() {
		var self = this;
		$.ajax({
			url: Omoide.Config.api_endpoint + "/photo/list.json",
			type: "get",
			data: {
				password: Omoide.Config.api_password
			},
			dataType: "json",
			cache: false,
			success: function(json) {
				console.log(json);
				if (json && typeof json.list) {
					self.view.appendImages(json.list);
				}
			}
		});
	},


	_: null
};

})(window);
