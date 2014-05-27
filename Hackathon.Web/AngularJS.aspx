<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div ng-app ng-controller="App" ng-cloak>
    <div class="row">
        <div class="col-xs-6" style="min-height: 400px">
            <div class="wh-list">
                <ul>
                    <!--   -->
                    <li ng-repeat="item in items | filter: { Name: categoryFilter } | filter: ApplyNeedsRepairFilter" ng-click="Select(item)">
                        <a href="#">
                            <span>{{item.Name}}</span>
                            <span> - </span>
                            <span>{{item.ComputedValue()}}</span>
                            <span> - </span>
                            <span>{{item.ComputedRepairProbability()}}</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-6">
            <form class="form-horizontal wh-list-filter">
                <fieldset>

                    <!-- Form Name -->
                    <legend>List Filters</legend>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="categoryfilter">Title</label>
                        <div class="col-md-5">
                            <input id="categoryfilter" name="categoryfilter" type="text" placeholder="" class="form-control input-md" ng-model="categoryFilter">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="valueMultiplier">Value multiplier</label>
                        <div class="col-md-5">
                            <input name="valueMultiplier" type="text" placeholder="" class="form-control input-md" ng-model="valueMultiplier">

                        </div>
                    </div>

                    <!-- Multiple Checkboxes -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="attributefilter">Atrributes</label>
                        <div class="col-md-4">
                            <div class="checkbox">
                                <label for="attributefilter-0">
                                    <input type="checkbox" name="attributefilter" id="attributefilter-0" value="1" ng-model="needsRepairFilter">
                                    Needs Repair
                                </label>
                            </div>
                        </div>
                    </div>

                </fieldset>
            </form>
        </div>
        <div class="col-xs-6">
            <div class="wh-item-detail" ng-if="selectedItem">
                <div class="name" ng-bind="selectedItem.Name"></div>
                <div class="category">
                    <span>Value: </span>
                    <span ng-bind="selectedItem.ComputedValue()"></span>
                </div>
                <div class="description" ng-bind="selectedItem.Description">Description</div>
            </div>
        </div>
    </div>
 </div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/angular-1.2.6.min.js"></script>
<script type="text/javascript">
    function App($scope, $http) {
        $scope.items = [];
        $scope.selectedItem = null;
        $scope.categoryFilter = "";
        $scope.valueMultiplier = "1";
        $scope.needsRepairFilter = false;
        $scope.Select = function(item) {
            $scope.selectedItem = item;
        }
        $scope.ApplyNeedsRepairFilter = function(item) {
            return !$scope.needsRepairFilter || item.NeedsRepair;
        }
        
        // put your angular-using code here.  Angular knows to call this because the function name matches the ng-controller attribute above
        $http.get('/Services.svc/GetData').success(function(data) {
            $scope.items = $.map(data, function(i) {
                i.ComputedValue = function() {
                    var mult = parseFloat($scope.valueMultiplier || "1");
                    var value = i.CurrentValue * mult;
                    return "$" + value.toFixed(2);
                };
                i.ComputedRepairProbability = function() {
                    return (i.RepairProbabilityInNext90Days).toFixed(0) + "%";
                };
                return i;
            });
        });
    }
</script>
</asp:Content>

