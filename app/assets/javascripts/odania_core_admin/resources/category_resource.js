app.factory('CategoryResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/menus/:menuId/categories/:id');

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
