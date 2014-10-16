app.controller('EditMenuController', ['$location', '$scope', '$rootScope', 'MenuResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, MenuResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditMenuController");
	var menuId = null;

	function loadMenu(id) {
		MenuResource.get({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function (data) {
			$scope.menu = data;
		});
	}

	function saveMenu() {
		if (menuId) {
			MenuResource.update({siteId: $rootScope.currentSite.id, id: menuId, menu: $scope.menu}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			MenuResource.save({siteId: $rootScope.currentSite.id, menu: $scope.menu}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess(data) {
		$location.path('/menus/'+data.id);
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$scope.saveMenu = saveMenu;
	$scope.menu = {
		'language_id': null
	};

	if ($routeParams.id) {
		menuId = $routeParams.id;
		loadMenu(menuId);
	}
}]);
