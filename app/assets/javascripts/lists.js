var projectsList = angular.module('projectsList', ['ui.bootstrap', 'ui.sortable']);

/**
 * Mediator
 */
projectsList
    .factory('$mediator', function ($rootScope) {
        return $rootScope.$new(true);
    });

/**
 * Projects List Controller
 */
projectsList
    .controller('projectsListController', ['$scope', '$http', '$attrs', '$modal', '$mediator',
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
            }

            var replaceProject = function (project) {
                for (var key in $scope.projects) {
                    if (project.id === $scope.projects[key].id) {
                        $scope.projects[key] = project;
                        break;
                    }
                }
            }

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
            }

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
            }

            /**
             * Enable edit project by id
             *
             * @param id
             */
            $scope.edit = function (id) {
                getProjectById(id).enable_edit = true;
            }

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
            }

            $mediator.$on('create_project', function (event, project) {
                $scope.projects.push(project);
            });

            $mediator.$on('replace_project', function (event, project) {
                replaceProject(project);
            });

            $scope.loadProjectsList();
        }
    ]);

/**
 * Add Project Controller
 */
projectsList
    .controller('addProjectController', ['$scope', '$http', '$attrs', '$mediator',
        function ($scope, $http, $attrs, $mediator) {
            $scope.toggle = false;

            /**
             * Hide form
             */
            $scope.hide = function () {
                $scope.toggle = false;
                $scope.project.title = '';
            }

            /**
             * Show form
             *
             * @return boolean
             */
            $scope.show = function () {
                var result = false === $scope.toggle;

                $scope.toggle = true;

                return result;
            }

            /**
             * Submit form data
             *
             * @param project
             */
            $scope.submit = function (project) {
                var titleInvalid = (undefined === project || '' === project.title);
                $scope.add_project['project[title]'].$setValidity('required', $scope.show() || !titleInvalid);

                if (!titleInvalid) {
                    $scope.disabled_submit = true;
                    $scope.server_errors = {};

                    $http({
                        method  : $attrs.method,
                        url     : $attrs.action,
                        data    : { project: project }
                    }).success(function(data) {
                        if (data['success']) {
                            $scope.hide();
                            $scope.project.title = '';

                            $mediator.$emit('create_project', data['project']);
                        } else {
                            $scope.server_errors = data['errors'];
                        }

                        $scope.disabled_submit = false;
                    });
                }
            }
        }
    ]);

/**
 * Projects List Controller
 */
projectsList
    .controller('tasksListController', ['$scope', '$http', '$attrs', '$modal',
        function ($scope, $http, $attrs, $modal) {

           /**
            * Destroy task by id
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
                    for (var key in $scope.tasks) {
                        if (id === $scope.tasks[key].id) {
                            $scope.tasks.splice(key, 1);
                        }
                    }

                    $http.delete($attrs.tasksUrl + '/' + id);
                });
            }

            /**
             * Sortable options
             */
            $scope.sortableOptions = {
                stop: function() {
                    var resorted_data = [];
                    for (var key in $scope.tasks) {
                        resorted_data.push({
                            id: $scope.tasks[key].id,
                            order: key
                        });
                    }

                    $http.post($attrs.tasksResortedUrl, { tasks: resorted_data });
                },
                axis: 'y'
            };
        }
    ]);

/**
 * Add Task Controller
 */
projectsList
    .controller('addTaskController', ['$scope', '$http', '$attrs', '$mediator',
        function ($scope, $http, $attrs, $mediator) {
            $scope.disabled_submit = false;
            $scope.task = {}

            /**
             * Submit form data
             *
             * @param task
             * @param project
             */
            $scope.submit = function (task, project) {
                task.error = undefined == task.title || '' === task.title;

                if (!task.error) {
                    $scope.disabled_submit = true;

                    $http({
                        method  : $attrs.method,
                        url     : $attrs.action,
                        data    : { task: task, project: project }
                    }).success(function(data) {
                        if (data['success']) {
                            task.title = '';
                            project.tasks.push(data['task']);
                            $mediator.$emit('replace_project', project);
                        } else {
                            task.error = true;
                        }

                        $scope.disabled_submit = false;
                    });
                }
            }
        }
    ]);

/**
 * ProjectsList app initialize
 */
angular.element(document).ready(function() {
    angular.bootstrap(document.getElementById('projectsList'), ['projectsList']);
});