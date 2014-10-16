app.controller('EditMenuItemController', ['$location', '$scope', '$rootScope', 'MenuItemResource', '$routeParams', function ($location, $scope, $rootScope, MenuItemResource, $routeParams) {
	console.log("controller :: EditMenuItemController");
	var menuId = $routeParams.menuId,
		menuItemId = null;

	function loadMenuItem(id) {
		MenuItemResource.get({siteId: $rootScope.currentSite.id, menuId: menuId, id: id}).$promise.then(function (data) {
			$scope.menuItem = data;
			$scope.targetData = data.target_data;
		});
	}

	function saveMenuItem() {
		if (menuItemId) {
			MenuItemResource.update({siteId: $rootScope.currentSite.id, menuId: menuId, id: menuItemId, menu_item: $scope.menuItem, target_data: $scope.targetData}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			MenuItemResource.save({siteId: $rootScope.currentSite.id, menuId: menuId, menu_item: $scope.menuItem, target_data: $scope.targetData}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/menus/'+menuId+'/menu_items');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$scope.saveMenuItem = saveMenuItem;
	$scope.menuItem = {
		'title': null
	};
	$scope.targetData = {};

	if ($routeParams.id) {
		menuItemId = $routeParams.id;
		loadMenuItem(menuItemId);
	}

	MenuItemResource.initialData({siteId: $rootScope.currentSite.id, menuId: menuId}).$promise.then(function (data) {
		$scope.data = data;
	});
}]);
