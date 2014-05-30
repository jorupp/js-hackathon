<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div ng-app ng-controller="App" ng-cloak>
    <div class="row">
        <div class="col-xs-6" style="min-height: 400px">
            <table id="myGrid"></table>
            <div id="myPager"></div>
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
                        <label class="col-md-4 control-label" for="descriptionfilter">Description</label>
                        <div class="col-md-5">
                            <input id="descriptionfilter" name="descriptionfilter" type="text" placeholder="" class="form-control input-md" ng-model="descriptionFilter">

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
                    <span ng-bind="selectedItem.CurrentValue"></span>
                </div>
                <div class="description" ng-bind="selectedItem.Description">Description</div>
            </div>
        </div>
    </div>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/ui-lightness/jquery-ui-1.10.4.css" />
    <link rel="stylesheet" href="/Content/css/ui.jqgrid.css" />
    <style type="text/css">
        .name-needs-repair {
            color: red;
        }
        .repair-red {
            background-color: red;
            color: white;
        }
        .repair-yellow {
            background-color: yellow;
            color: black;
        }
        .repair-green {
            background-color: green;
            color: black;
        }
    </style>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/Scripts/i18n/grid.locale-en.js"></script>
<script type="text/javascript" src="/Scripts/angular-1.2.6.min.js"></script>
<script type="text/javascript">
    function App($scope) {
        // put your angular-using code here.  Angular knows to call this because the function name matches the ng-controller attribute above
        $scope.message = "Hello from Angular";
        var grid = $("#myGrid");

        $(function () {
            grid.jqGrid({
                colNames: ["Id", "Name", "Description", "Repair Probability (next 90 days)", "Current Value", "Needs Repair"],
                colModel: [
                    { name: 'Id', index: 'Id', hidden: true },
                    { name: 'Name', index: 'Name' },
                    { name: 'Description', index: 'Description', hidden: true },
                    { name: 'RepairProbabilityInNext90Days', index: 'RepairProbabilityInNext90Days', align: 'right', formatter: function (v) {
                        return parseFloat(v).toFixed(0) + "%";
                    } },
                    { name: 'CurrentValue', index: 'CurrentValue', align: 'right', formatter: function(v) {
                        return "$" + parseFloat(v).toFixed(2);
                    } },
                    { name: 'NeedsRepair', index: 'NeedsRepair' }
                ],
                rowNum: 20,
                rowList: [20, 40, 60, 80, 100],
                pager: $("#myPager")[0],
                data: [],
                datatype: 'json',
                mtype: 'GET',
                url: '/Services.svc/GetDataForJQGrid',
                autowidth: true,
                height: 'auto',
                jsonReader: { id: "Id", userdata: "rows", repeatitems: false },
                afterInsertRow: function(id, data)
                {
                    var row = grid.find('tr#' + id);
                    var cells = row.children("td");
                    if (data.NeedsRepair) {
                        cells.eq(1).addClass("name-needs-repair");
                    }
                    if (data.RepairProbabilityInNext90Days == 100) {
                        cells.eq(3).addClass("repair-red");
                    } else if (data.RepairProbabilityInNext90Days >= 80) {
                        cells.eq(3).addClass("repair-yellow");
                    } else {
                        cells.eq(3).addClass("repair-green");
                    }
                }
            });
            grid.on("jqGridSelectRow", function (evt, id, status, e) {
                var data = grid.jqGrid("getRowData", id);
                $scope.selectedItem = data;
                $scope.$apply();
            });
        });
        
        $scope.selectedItem = null;
        $scope.categoryFilter = "";
        $scope.descriptionFilter = "";
        $scope.needsRepairFilter = false;

        $scope.$watch("categoryFilter", function () {
            grid.jqGrid("setGridParam", { postData: { Name: $scope.categoryFilter } });
            grid.trigger("reloadGrid");
            $scope.selectedItem = null;
        });

        $scope.$watch("descriptionFilter", function () {
            grid.jqGrid("setGridParam", { postData: { Description: $scope.descriptionFilter } });
            grid.trigger("reloadGrid");
            $scope.selectedItem = null;
        });

        $scope.$watch("needsRepairFilter", function () {
            var filter = $scope.needsRepairFilter ? true : null;
            grid.jqGrid("setGridParam", { postData: { NeedsRepair: filter } });
            grid.trigger("reloadGrid");
            $scope.selectedItem = null;
        });
    }
</script>
</asp:Content>

