app.controller('EditWidgetController', ['$location', '$scope', '$rootScope', 'WidgetResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, WidgetResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditWidgetController");
	var widgetId = null;

	function loadWidget(id) {
		WidgetResource.get({siteId: $rootScope.currentSite.id, id: id}).$promise.then(function (data) {
			$scope.widget.name = data.name;
			$scope.widget.template = data.template;
			$scope.widget.content = data.content;
			$scope.widget.contents = {};

			selectWidget();

			if ($scope.selectedWidget.is_array) {
				$scope.widget.contents = data.content.data;
				$scope.widget.content.data = null;
			}
		});
	}

	function saveWidget() {
		if (widgetId) {
			WidgetResource.update({siteId: $rootScope.currentSite.id, id: widgetId, widget: $scope.widget}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			WidgetResource.save({siteId: $rootScope.currentSite.id, widget: $scope.widget}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/widgets');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	function selectWidget() {
		var widget;

		for (var i = 0; i < $rootScope.admin.widgets.length; i++) {
			widget = $rootScope.admin.widgets[i];

			if ($scope.widget.template == widget.template) {
				$scope.selectedWidget = widget;
				console.log("widget", $scope.selectedWidget);
				return;
			}
		}
	}

	$scope.saveWidget = saveWidget;
	$scope.selectWidget = selectWidget;
	$scope.addContents = function () {
		$scope.widget.contents.push({});
		console.log($scope.widget);
	};
	$scope.prepareKey = function (parameter) {
		console.warn('parameter', parameter, $scope.widget.content[parameter.key]);

		if (!$scope.widget.content[parameter.key]) {
			$scope.widget.content[parameter.key] = [];
		}

		var lastIdx = $scope.widget.content[parameter.key].length - 1;
		if (lastIdx < 0) {
			$scope.widget.content[parameter.key].push({});
			return true;
		}

		console.warn('lastIdx', lastIdx, $scope.widget.content[parameter.key][lastIdx],
			"K", Object.keys($scope.widget.content[parameter.key][lastIdx]),
			"L", Object.keys($scope.widget.content[parameter.key][lastIdx]).length);
		if (Object.keys($scope.widget.content[parameter.key][lastIdx]).length > 1) {
			$scope.widget.content[parameter.key].push({});
		}

		return true;
	};
	$scope.widget = {
		'name': '',
		'template': '',
		'content': {},
		'contents': [
			{}
		]
	};

	if ($routeParams.id) {
		widgetId = $routeParams.id;
		loadWidget(widgetId);
	}
}]);
