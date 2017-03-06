app.controller('CategoryController', ['$rootScope', '$scope', 'CategoryResource', '$routeParams', 'eventTypeProvider', '$location',
	function ($rootScope, $scope, CategoryResource, $routeParams, eventTypeProvider, $location) {
	console.log("controller :: CategoryController");

	function loadCategory(id) {
		CategoryResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.category = data.category;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/categories');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/categories');
	});

	loadCategory($routeParams.id);
}]);
