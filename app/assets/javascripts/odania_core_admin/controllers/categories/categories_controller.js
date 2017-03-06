app.controller('CategoriesController', ['$rootScope', '$scope', 'CategoryResource', 'eventTypeProvider', '$location', function ($rootScope, $scope, CategoryResource, eventTypeProvider, $location) {
	console.log("controller :: CategoriesController");

	if (!$rootScope.currentSite || !$rootScope.currentMenu) {
		$location.path('/menus');
	}

	function loadCategories() {
		if ($rootScope.currentMenu) {
			CategoryResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id}).$promise.then(function (data) {
				$scope.categories = data.categories;
			});
		} else {
			$scope.categories = [];
		}
	}

	function deleteCategory(id) {
		CategoryResource.delete({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function () {
			loadCategories();
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadCategories();
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		loadCategories();
	});

	$scope.deleteCategory = deleteCategory;
	$scope.categories = [];

	loadCategories();
}]);
