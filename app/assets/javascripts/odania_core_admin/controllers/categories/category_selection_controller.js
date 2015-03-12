app.controller('CategorySelectionController', ['$rootScope', '$scope', 'CategoryResource', function ($rootScope, $scope, CategoryResource) {
	console.log("controller :: CategorySelectionController");

	$scope.addNewCategory = function() {
		CategoryResource.save({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, category: $scope.newCategory}).$promise.then(function (data) {
			$rootScope.categories = data.categories;
		}, function (err) {
			$scope.errors = err.data.errors;
		});
	};

	$scope.newCategory = {
		'title': '',
		parent_id: null
	};
}]);
