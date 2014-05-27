<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div id="app">
    <div class="row">
        <div class="col-xs-6" style="min-height: 400px">
            <div class="wh-list">
                <ul data-bind="foreach: { data: visibleItems }">
                    <li data-bind="click: $parent.Select">
                        <a href="#">
                            <span data-bind="text: Name"></span>
                            <span> - </span>
                            <span data-bind="text: ComputedValue"></span>
                            <span> - </span>
                            <span data-bind="text: ComputedRepairProbability"></span>
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
                            <input id="categoryfilter" name="categoryfilter" type="text" placeholder="" class="form-control input-md" data-bind="value: categoryFilter">

                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label class="col-md-4 control-label" for="valueMultiplier">Value multiplier</label>
                        <div class="col-md-5">
                            <input name="valueMultiplier" type="text" placeholder="" class="form-control input-md" data-bind="value: valueMultiplier">

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

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/knockout-3.1.0.js"></script>
<script type="text/javascript">
    (function() {
        // put your knockout-using code here
        var model = {
             message: ko.observable("Hello from Knockout"),
             items: ko.observableArray([]),
             selectedItem: ko.observable(null),
             categoryFilter: ko.observable(""),
             valueMultiplier: ko.observable("1"),
             needsRepairFilter: ko.observable(false),
             Select: function(item) {
                 model.selectedItem(item);
             }
        };
        model.visibleItems = ko.computed(function() {
            var filter = model.categoryFilter();
            var items = $.grep(model.items(), function(item) {
                return (!filter || item.Name.indexOf(filter) > -1) && (!model.needsRepairFilter() || item.NeedsRepair)
                ;
            });
            return items;
         }),


        $.ajax({
            url: "/Services.svc/GetData",
            method: "GET",
            success: function(data) {
                for (var i in data) {
                    (function() {
                        var m = data[i];
                        m.ComputedValue = ko.computed(function() {
                            var mult = parseFloat(model.valueMultiplier() || "1");
                            var value = m.CurrentValue * mult;
                            return "$" + value.toFixed(2);
                        });
                        m.ComputedRepairProbability = ko.computed(function() {
                            return (m.RepairProbabilityInNext90Days).toFixed(0) + "%";
                        });
                        model.items.push(m);
                    })();
                }
            }
        });

        // this wires the model into the DOM    
        ko.applyBindings(model, $("#app")[0]);
    })();
</script>
</asp:Content>

