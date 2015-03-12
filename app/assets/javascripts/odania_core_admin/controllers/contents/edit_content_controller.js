app.controller('EditContentController', ['$location', '$scope', '$rootScope', 'ContentResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, ContentResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditContentController");
	var languageId = null;

	function loadContent(id) {
		ContentResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.content = data.content;
			$scope.content.category_selection = getCategoryTitles(data.content.categories);
			$scope.content.tagSelection = getTagList(data.content.tags);
			$scope.data = data.data;
			$rootScope.categories = $scope.data.categories;
		});
	}

	function saveContent() {
		$scope.content.language_id = $rootScope.currentMenu.language_id;
		$scope.content.category_list = $rootScope.getAsStringList($scope.content.category_selection);
		if ($scope.content.tagSelection) {
			$scope.content.tag_list = $scope.content.tagSelection.join(',');
		}

		if (languageId) {
			ContentResource.update({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: languageId, content: $scope.content}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			ContentResource.save({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, content: $scope.content}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/contents');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	function getCategoryTitles(categories) {
		var titles = {};

		for (var i=0 ; i<categories.length ; i++) {
			titles[categories[i].title] = true;
		}

		return titles;
	}

	function getTagList(tags) {
		var result = [];

		for (var i=0 ; i<tags.length ; i++) {
			result.push(tags[i].name);
		}

		return result;
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$scope.saveContent = saveContent;
	$scope.content = {
		'title': '',
		'tagSelection': []
	};

	if ($routeParams.id) {
		languageId = $routeParams.id;
		loadContent($routeParams.id);
	}
}]);
