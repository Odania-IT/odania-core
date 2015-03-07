app.factory('StaticPageResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/menus/:menuId/static_pages/:id');

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
