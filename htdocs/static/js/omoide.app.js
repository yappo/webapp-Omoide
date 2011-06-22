(function(window) {
if (typeof(window.Omoide) == 'undefined') {
	window.Omoide = {};
}

window.Omoide.Config = {
	api_endpoint: "/api/v1",
	api_password: "mayue",

	_: null
};

window.Omoide.createImageUrl = function(size, id, isLogin) {
	var path = "/p/" + size + "/" + id;
	if (isLogin) {
		path = path + "?password=" + Omoide.Config.api_password;
	}
	return path;
};

$(function() {

var imageList = new Omoide.Controller.ImageList({
	containerId: "#imageList"
});
console.log(imageList);
imageList.open();

});

})(window);
