(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}

window.Omoide.Config = {
	api_endpoint: "/api/v1",

	_: null
};

$(function() {

var imageList = new Omoide.Controller.ImageList();
console.log(imageList);

});

})(window);
