app.factory('MenuResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/menus/:id');

	return $resource(basePath, {
		'id': '@id',
		'siteId': '@siteId'
	}, {
		'update': {
			'method': 'PUT'
		}
	});
}]);
