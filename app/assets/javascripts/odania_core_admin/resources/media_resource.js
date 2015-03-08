app.factory('MediaResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/menus/:menuId/medias/:id');

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
