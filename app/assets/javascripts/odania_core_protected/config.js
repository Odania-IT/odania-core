function Config() {
	this.getApiPath = function getApiPath(path) {
		return '/protected/api/' + path;
	};

	this.getTemplatePath = function getTemplatePath(name, type) {
		if (type) {
			return ['/'+type+'/templates', '.html'].join('/' + name);
		}

		return ['/protected/templates', '.html'].join('/' + name);
	};
}

var config = new Config();
