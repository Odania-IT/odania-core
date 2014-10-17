app.controller('MenuController', ['$rootScope', '$scope', 'MenuResource', '$routeParams', 'eventTypeProvider', '$location', function ($rootScope, $scope, MenuResource, $routeParams, eventTypeProvider, $location) {
	console.log("controller :: MenuController");

	function loadMenu(id) {
		MenuResource.get({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function (data) {
			$scope.menu = data.menu;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/menus');
	});

	loadMenu($routeParams.id);
}]);
