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

	return this;
};

window.Omoide.Controller.MainContainer.prototype = {
	albumListContainer: null,
	imageListContainer: null,
	containerId: null,

	fixupContainerSize: function() {
		this.albumListContainer.view.fixupContainerSize();
		this.imageListContainer.view.fixupContainerSize();		
	},


	_: null
};

})(window);
