function Config() {
	this.getApiPath = function getApiPath(path) {
		return '/protected/api/' + path;
	};

	this.getTemplatePath = function getTemplatePath(name) {
		return ['/protected/templates', '.html'].join('/' + name);
	};
}

var config = new Config();
