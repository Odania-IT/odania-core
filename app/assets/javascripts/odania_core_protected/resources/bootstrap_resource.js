app.factory('BootstrapResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('bootstrap');

	return $resource(basePath, {}, {
		'changeLanguage': {
			'method': 'POST',
			'url': basePath + '/change_language'
		}
	});
}]);
