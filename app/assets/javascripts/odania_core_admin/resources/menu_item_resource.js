app.factory('MenuItemResource', ['$resource', function ($resource) {
	var basePath = config.getApiPath('sites/:siteId/menus/:menuId/menu_items/:id');

	return $resource(basePath, {
		'id': '@id',
		'siteId': '@siteId',
		'menuId': '@menuId'
	}, {
		'update': {
			'method': 'PUT'
		},
		'initialData': {
			'method': 'GET',
			'url': basePath + '/initial_data'
		},
		'setDefault': {
			'method': 'POST',
			'url': basePath + '/set_default'
		}
	});
}]);
