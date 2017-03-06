app.controller('EditCategoryController', ['$location', '$scope', '$rootScope', 'CategoryResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, CategoryResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditCategoryController");
	var categoryId = null;

	function loadCategory(id) {
		CategoryResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.category = data.category;
		});
	}

	function saveCategory() {
		$scope.category.language_id = $rootScope.currentMenu.language_id;

		if (categoryId) {
			CategoryResource.update({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: categoryId, category: $scope.category}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			CategoryResource.save({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, category: $scope.category}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/categories');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/categories');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/categories');
	});

	$scope.saveCategory = saveCategory;
	$scope.category = {
		'title': ''
	};

	if ($routeParams.id) {
		categoryId = $routeParams.id;
		loadCategory($routeParams.id);
	}
}]);
