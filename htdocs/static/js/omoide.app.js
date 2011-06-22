(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}

window.Omoide.Config = {
	api_endpoint: "/api/v1",
	api_password: "mayue",

	_: null
};

$(function() {

var imageList = new Omoide.Controller.ImageList({
	containerId: "#imageList"
});
console.log(imageList);
imageList.open();

});

})(window);
