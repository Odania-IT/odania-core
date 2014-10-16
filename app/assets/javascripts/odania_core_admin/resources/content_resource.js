app.factory('ContentResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/menus/:menuId/contents/:id');

	return $resource(basePath, {
		'id': '@id',
		'siteId': '@siteId',
		'menuId': '@menuId'
	}, {
		'update': {
			'method': 'PUT'
		}
	});
}]);
