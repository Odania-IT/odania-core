function Config() {
	this.getApiPath = function getApiPath(path) {
		return '/admin/api/' + path;
	};

	this.getTemplatePath = function getTemplatePath(name, type) {
		if (type) {
			return ['/'+type+'/templates', '.html'].join('/' + name);
		}

		return ['/admin/templates', '.html'].join('/' + name);
	};
}

var config = new Config();
