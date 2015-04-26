app.factory('MediaResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('medias/:id');

	return $resource(basePath, {
		'id': '@id'
	}, {
		'update': {
			'method': 'PUT'
		}
	});
}]);
