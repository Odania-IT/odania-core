app.controller('StaticPagesController', ['$rootScope', '$scope', 'StaticPageResource', 'eventTypeProvider', '$location', function ($rootScope, $scope, StaticPageResource, eventTypeProvider, $location) {
	console.log("controller :: StaticPagesController");

	if (!$rootScope.currentSite || !$rootScope.currentMenu) {
		$location.path('/menus');
	}

	function loadStaticPages() {
		if ($rootScope.currentMenu) {
			StaticPageResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id}).$promise.then(function (data) {
				$scope.staticPages = data.static_pages;
			});
		} else {
			$scope.staticPages = [];
		}
	}

	function deleteStaticPage(id) {
		StaticPageResource.delete({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function () {
			loadStaticPages();
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadStaticPages();
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		loadStaticPages();
	});

	$scope.deleteStaticPage = deleteStaticPage;
	$scope.staticPages = [];

	loadStaticPages();
}]);
