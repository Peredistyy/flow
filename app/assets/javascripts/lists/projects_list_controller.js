/**
 * Projects List Controller
 */
projectsList.controller('projectsListController', ['$scope', '$http', '$attrs', '$modal', '$mediator',
    function ($scope, $http, $attrs, $modal, $mediator) {
        $scope.show_loader = false;
        $scope.projects = [];

        var getProjectById = function (id) {
            var project;

            for (var key in $scope.projects) {
                if (id === $scope.projects[key].id) {
                    project = $scope.projects[key];
                    break;
                }
            }

            return project;
        };

        /**
         * Load all project current user
         */
        $scope.loadProjectsList = function () {
            $scope.show_loader = true;

            $http
                .get($attrs.projectsUrl)
                .then(function(response){
                    if (response.data['success']) {
                        $scope.projects = response.data['projects'];
                    }

                    $scope.show_loader = false;
                });
        };

        /**
         * Destroy project by id
         *
         * @param id
         */
        $scope.destroy = function (id) {
            var modalInstance = $modal.open({
                templateUrl: 'destroy_confirm',
                controller: function($scope, $modalInstance) {
                    $scope.yes = function() {
                        $modalInstance.close();
                    };

                    $scope.no = function() {
                        $modalInstance.dismiss('cancel');
                    };
                }
            });

            modalInstance.result.then(function() {
                for (var key in $scope.projects) {
                    if (id === $scope.projects[key].id) {
                        $scope.projects.splice(key, 1);
                    }
                }

                $http.delete($attrs.projectsUrl + '/' + id);
            });
        };

        /**
         * Enable edit project by id
         *
         * @param id
         */
        $scope.edit = function (id) {
            getProjectById(id).enable_edit = true;
        };

        /**
         * Save project
         *
         * @param id
         */
        $scope.save = function (id) {
            var project = getProjectById(id);

            project.error = false;

            $http({
                method  : 'put',
                url     : $attrs.projectsUrl + '/' + id,
                data    : { project: project }
            }).success(function(data) {
                if (data['success']) {
                    project.enable_edit = false;
                } else {
                    project.error = true;
                }
            });
        };

        $mediator.$on('create_project', function (event, project) {
            $scope.projects.push(project);
        });

        $scope.loadProjectsList();
    }
]);