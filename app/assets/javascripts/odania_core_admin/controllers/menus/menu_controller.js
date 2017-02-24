app.controller('MenuController', ['$rootScope', '$scope', 'MenuResource', 'MenuItemResource', '$routeParams', 'eventTypeProvider', '$location', function ($rootScope, $scope, MenuResource, MenuItemResource, $routeParams, eventTypeProvider, $location) {
	console.log("controller :: MenuController");

	function loadMenu() {
		MenuItemResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id}).$promise.then(function (data) {
			$scope.menuItems = data.menu_items;
			$scope.menu = data.menu;
		});
	}

	function saveMenu() {
		MenuResource.update({siteId: $rootScope.currentSite.id, id: $rootScope.currentMenu.id, menu: $scope.menu}).$promise.then(function (data) {
			$scope.menu = data.menu;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/menus');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadMenu();
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		loadMenu();
	});

	$scope.getMenuItem = function (id) {
		var menuItem;

		for (var i=0 ; i<$scope.menuItems.length ; i++) {
			menuItem = $scope.menuItems[i];

			if (menuItem.id == id) {
				return menuItem;
			}
		}

		return null;
	};

	$scope.setDefaultMenuItem = function (id) {
		MenuItemResource.setDefault({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.menuItems = data.menu_items;
			$scope.menu = data.menu;
		});
	};

	$scope.saveMenu = saveMenu;
	$scope.menu = {
		'language_id': null
	};

	loadMenu();
}]);