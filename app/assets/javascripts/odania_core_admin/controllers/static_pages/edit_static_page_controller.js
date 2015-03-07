app.controller('EditStaticPageController', ['$location', '$scope', '$rootScope', 'StaticPageResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, StaticPageResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditStaticPageController");
	var languageId = null;

	function loadStaticPage(id) {
		StaticPageResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.staticPage = data.static_page;
		});
	}

	function saveStaticPage() {
		$scope.staticPage.language_id = $rootScope.currentMenu.language_id;
		if (languageId) {
			StaticPageResource.update({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: languageId, static_page: $scope.staticPage}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			StaticPageResource.save({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, static_page: $scope.staticPage}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/contents');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$scope.saveStaticPage = saveStaticPage;
	$scope.staticPage = {
		'title': ''
	};

	if ($routeParams.id) {
		languageId = $routeParams.id;
		loadStaticPage($routeParams.id);
	}

}]);
