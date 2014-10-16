app.factory('LanguageResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('languages/:id');

	return $resource(basePath, {
		'id': '@id'
	}, {
		'update': {
			'method': 'PUT'
		}
	});
}]);
