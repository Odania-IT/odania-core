app.controller('ImageSelectController', ['$scope', '$modalInstance', 'MediaResource', function ($scope, $modalInstance, MediaResource) {
	MediaResource.get({
		siteId: $rootScope.currentSite.id,
		menuId: $rootScope.currentMenu.id
	}).$promise.then(function (data) {
		$scope.medias = data.medias;
	});

	$scope.modalOptions = {};

	$scope.modalOptions.ok = function () {
		if ($scope.selectedImage.src == null) {
			$scope.errors.display_no_image_selected = true;
			return;
		}

		$modalInstance.close($scope.selectedImage);
	};
	$scope.modalOptions.close = function () {
		$modalInstance.dismiss('cancel');
	};

	$scope.selectedImage = {
		'src': null,
		'alt': '',
		'title': ''
	};
	$scope.errors = {
		'no_image_selected': true,
		'display_no_image_selected': false
	};
}]);
