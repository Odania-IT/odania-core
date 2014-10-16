app.factory('SiteResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:id');

	return $resource(basePath, {
		'id': '@id'
	}, {
		'update': {
			'method': 'PUT'
		}
	});
}]);
