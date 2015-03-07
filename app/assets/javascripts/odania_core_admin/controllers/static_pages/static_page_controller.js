app.controller('StaticPageController', ['$rootScope', '$scope', 'StaticPageResource', '$routeParams', 'eventTypeProvider', '$location', function ($rootScope, $scope, StaticPageResource, $routeParams, eventTypeProvider, $location) {
	console.log("controller :: StaticPageController");

	function loadStaticPage(id) {
		StaticPageResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.staticPage = data.static_page;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/static_pages');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/static_pages');
	});

	loadStaticPage($routeParams.id);
}]);
