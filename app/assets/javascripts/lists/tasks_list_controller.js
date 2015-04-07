/**
 * Tasks List Controller
 */
projectsList.controller('tasksListController', ['$scope', '$http', '$attrs', '$modal', '$mediator',
    function ($scope, $http, $attrs, $modal, $mediator) {
        $scope.tasks = [];
        $scope.project;

        var getTaskById = function (id) {
            var task;

            for (var key in $scope.tasks) {
                if (id === $scope.tasks[key].id) {
                    task = $scope.tasks[key];
                    break;
                }
            }

            return task;
        };

        /**
         * Tasks setter
         *
         * @param tasks
         */
        $scope.setTasks = function (tasks) {
            $scope.tasks = tasks;
            for (var key in $scope.tasks) {
                if (null != $scope.tasks[key].deadline) {
                    $scope.tasks[key].deadline = new Date($scope.tasks[key].deadline);
                } else {
                    $scope.tasks[key].deadline = '';
                }

            }
        };

        /**
         * Project setter
         *
         * @param project
         */
        $scope.setProject = function (project) {
            $scope.project = project;
        };

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
        };

        /**
         * Open task by id
         *
         * @param id
         */
        $scope.open = function (id) {
            getTaskById(id).opened = !getTaskById(id).opened;
        };

        /**
         * Enable edit task by id
         *
         * @param id
         */
        $scope.edit = function (id) {
            getTaskById(id).enable_edit = true;
        };

        /**
         * Save task
         *
         * @param id
         */
        $scope.save = function (id) {
            var task = getTaskById(id);

            task.error = false;

            var clone_task = angular.copy(task);
            if (null != clone_task.deadline) {
                clone_task.deadline = new Date($.datepicker.formatDate('yy-mm-dd', clone_task.deadline));
            }

            $http({
                method  : 'put',
                url     : $attrs.tasksUrl + '/' + id,
                data    : { task: clone_task }
            }).success(function(data) {
                if (data['success']) {
                    task.enable_edit = false;
                } else {
                    task.error = true;
                }
            });
        };

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

        $mediator.$on('create_task', function (event, data) {
            if (data.project.id == $scope.project.id) {
                data.task.deadline = new Date('');
                $scope.tasks.push(data.task);
            }
        });
    }
]);