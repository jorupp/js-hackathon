<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div id="app">
    <div class="row">
        <div class="col-xs-6" style="min-height: 400px">
            <div id="myGrid" style="width:530px;height:500px;"></div>
            <%--<div id="myPager"></div>--%>
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
                            <input id="categoryfilter" name="categoryfilter" type="text" placeholder="" class="form-control input-md" data-bind="value: categoryFilter">

                        </div>
                    </div>

                    <!-- Multiple Checkboxes -->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="attributefilter">Atrributes</label>
                        <div class="col-md-4">
                            <div class="checkbox">
                                <label for="attributefilter-0">
                                    <input type="checkbox" name="attributefilter" id="attributefilter-0" value="1" data-bind="checked: needsRepairFilter">
                                    Needs Repair
                                </label>
                            </div>
                        </div>
                    </div>

                </fieldset>
            </form>
        </div>
        <div class="col-xs-6" data-bind="with: selectedItem">
            <div class="wh-item-detail">
                <div class="name" data-bind="text: Name"></div>
                <div class="category">
                    <span>Value: </span>
                    <span data-bind="text: ComputedValue"></span>
                </div>
                <div class="description" data-bind="text: Description">Description</div>
            </div>
        </div>
    </div>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/ui-lightness/jquery-ui-1.10.4.css" />
    <link rel="stylesheet" href="/Content/css/slick.grid.css" />
    <link rel="stylesheet" href="/Content/css/slick-default-theme.css" />
    <style>
        .loading-indicator {
            display: inline-block;
            padding: 12px;
            background: white;
            -opacity: 0.5;
            color: black;
            font-weight: bold;
            z-index: 9999;
            border: 1px solid red;
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            -moz-box-shadow: 0 0 5px red;
            -webkit-box-shadow: 0px 0px 5px red;
            -text-shadow: 1px 1px 1px white;
        }

        .loading-indicator label {
            padding-left: 20px;
            background: url('images/ajax-loader-small.gif') no-repeat center left;
        }
        .slick-header-column.ui-state-default {
            height: 22px;
        }
    </style>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery.event.drag-2.2.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.core.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.dataview.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.editors.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.formatters.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.grid.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.groupitemmetadataprovider.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/slick.remotemodel.js"></script>
<script type="text/javascript" src="/Scripts/slickgrid/plugins/slick.rowselectionmodel.js"></script>
<script type="text/javascript" src="/SlickGridRemoteModel.js"></script>
<script type="text/javascript" src="/Scripts/knockout-3.1.0.js"></script>
<script type="text/javascript">
    (function() {
        // put your knockout-using code here
        var model = {
            selectedItem: ko.observable(null),
            categoryFilter: ko.observable(""),
            needsRepairFilter: ko.observable(false),
        };

        // this wires the model into the DOM    
        ko.applyBindings(model, $("#app")[0]);

        var loader = new RemoteModel(model.categoryFilter, model.needsRepairFilter);

        var grid;
        $(function() {
            var columns = [
                //{id: "Id", name: "Id", field: "Id"},
                {id: "Name", name: "Name", field: "Name", width: 200, sortable: true},
                //{id: "Description", name: "Description", field: "Description"},
                { id: "RepairProbabilityInNext90Days", name: "Repair Probability (next 90 days)", field: "RepairProbabilityInNext90Days", width: 100, sortable: true },
                { id: "CurrentValue", name: "Current Value", field: "CurrentValue", formatter: function (r, c, v) { return "$" + parseFloat(v).toFixed(2); }, sortable: true },
                { id: "NeedsRepair", name: "Needs Repair", field: "NeedsRepair", sortable: true }
            ];

            var options = {
                enableCellNavigation: true,
                enableColumnReorder: false
            };

            grid = new Slick.Grid("#myGrid", loader.data, columns, options);
            grid.setSelectionModel(new Slick.RowSelectionModel());
            grid.onSelectedRowsChanged.subscribe(function () {
                var m = grid.getData()[grid.getSelectedRows()[0]];
                if (!m) {
                    model.selectedItem(null);
                    return;
                }
                m = $.extend({}, m); // copy
                m.ComputedValue = ko.computed(function () {
                    var value = parseFloat(m.CurrentValue);
                    return "$" + value.toFixed(2);
                });
                m.ComputedRepairProbability = ko.computed(function () {
                    return (m.RepairProbabilityInNext90Days).toFixed(0) + "%";
                });
                model.selectedItem(m);
            });


            grid.onViewportChanged.subscribe(function (e, args) {
                var vp = grid.getViewport();
                loader.ensureData(vp.top, vp.bottom);
            });

            grid.onSort.subscribe(function (e, args) {
                loader.setSort(args.sortCol.field, args.sortAsc ? 1 : -1);
                var vp = grid.getViewport();
                loader.ensureData(vp.top, vp.bottom);
            });

            var loadingIndicator = null;
            loader.onDataLoading.subscribe(function () {
                if (!loadingIndicator) {
                    loadingIndicator = $("<span class='loading-indicator'><label>Buffering...</label></span>").appendTo(document.body);
                    var $g = $("#myGrid");

                    loadingIndicator
                    .css("position", "absolute")
                    .css("top", $g.position().top + $g.height() / 2 - loadingIndicator.height() / 2)
                    .css("left", $g.position().left + $g.width() / 2 - loadingIndicator.width() / 2);
                }

                loadingIndicator.show();
            });

            loader.onDataLoaded.subscribe(function (e, args) {
                for (var i = args.from; i <= args.to; i++) {
                    grid.invalidateRow(i);
                }

                grid.updateRowCount();
                grid.render();

                loadingIndicator.fadeOut();
            });

            // load the first page
            grid.onViewportChanged.notify();
        });

        function reFilter() {
            model.selectedItem(null);
            grid.setSelectedRows([]);
            grid.resetActiveCell();
            loader.clear();

            var vp = grid.getViewport();
            loader.ensureData(vp.top, vp.bottom);

            grid.updateRowCount();
            grid.render();
        }

        model.categoryFilter.subscribe(reFilter);
        model.needsRepairFilter.subscribe(reFilter);
    })();
</script>
</asp:Content>

