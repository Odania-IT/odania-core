app.controller('MenuItemsController', ['$rootScope', '$scope', 'MenuItemResource', 'eventTypeProvider', '$routeParams', function ($rootScope, $scope, MenuItemResource, eventTypeProvider, $routeParams) {
	console.log("controller :: MenuItemsController");
	var menuId = $routeParams.menuId;

	function loadMenuItems() {
		MenuItemResource.get({siteId: $rootScope.currentSite.id, menuId: menuId}).$promise.then(function (data) {
			$rootScope.menuItems = data.menu_items;
			$rootScope.menu = data.menu;
		});
	}

	function deleteMenuItem(id) {
		MenuItemResource.delete({siteId: $rootScope.currentSite.id, menuId: menuId, id: id}).$promise.then(function () {
			loadMenuItems();
		});
	}

	$scope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadMenuItems();
	});

	$scope.deleteMenuItem = deleteMenuItem;
	$scope.setDefault = function (menuItem) {
		MenuItemResource.setDefault({siteId: $rootScope.currentSite.id, menuId: menuId, id: menuItem.id}).$promise.then(function (data) {
			$rootScope.menuItems = data.menu_items;
			$rootScope.menu = data.menu;
		});
	};

	loadMenuItems();
}]);
