app.factory('WidgetResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/widgets/:id');

	return $resource(basePath, {
		'id': '@id',
		'siteId': '@siteId'
	}, {
		'update': {
			'method': 'PUT'
		}
	});
}]);
