app.controller('MenuController', ['$rootScope', '$scope', 'MenuResource', '$routeParams', 'eventTypeProvider', function ($rootScope, $scope, MenuResource, $routeParams, eventTypeProvider) {
	console.log("controller :: MenuController");

	function loadMenu(id) {
		MenuResource.get({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function (data) {
			$scope.menu = data;
		});
	}

	loadMenu($routeParams.id);
}]);
