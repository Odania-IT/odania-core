app.controller('MenusController', ['$rootScope', '$scope', 'MenuResource', 'eventTypeProvider', function ($rootScope, $scope, MenuResource, eventTypeProvider) {
	console.log("controller :: MenusController");

	function loadMenus() {
		MenuResource.get({siteId: $rootScope.currentSite.id}).$promise.then(function (data) {
			$rootScope.menus = data.menus;
		});
	}

	function deleteMenu(id) {
		MenuResource.delete({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function () {
			loadMenus();
		});
	}

	$scope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadMenus();
	});

	$scope.deleteMenu = deleteMenu;

	loadMenus();
}]);
