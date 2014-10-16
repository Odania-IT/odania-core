app.controller('ContentController', ['$rootScope', '$scope', 'ContentResource', '$routeParams', 'eventTypeProvider', '$location', function ($rootScope, $scope, ContentResource, $routeParams, eventTypeProvider, $location) {
	console.log("controller :: ContentController");

	function loadContent(id) {
		ContentResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.content = data;
		});
	}

	$scope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$scope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	loadContent($routeParams.id);
}]);
