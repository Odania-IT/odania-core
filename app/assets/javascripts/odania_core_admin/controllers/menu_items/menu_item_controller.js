app.controller('MenuItemController', ['$rootScope', '$scope', 'MenuItemResource', '$routeParams', function ($rootScope, $scope, MenuItemResource, $routeParams) {
	console.log("controller :: MenuItemController");
	var menuId = $routeParams.menuId;

	function loadMenuItems(id) {
		MenuItemResource.get({siteId: $rootScope.currentSite.id, menuId: menuId, id: id}).$promise.then(function (data) {
			$scope.menu = data;
		});
	}

	loadMenuItems($routeParams.id);
}]);
