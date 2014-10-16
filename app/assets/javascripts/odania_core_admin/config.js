function Config() {
	this.getApiPath = function getApiPath(path) {
		return '/admin/api/' + path;
	};

	this.getTemplatePath = function getTemplatePath(name) {
		return ['/admin/templates', '.html'].join('/' + name);
	};
}

var config = new Config();
