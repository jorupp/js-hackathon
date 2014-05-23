<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div ng-app ng-controller="App" ng-cloak>
    <div id="myGrid" style="width:600px;height:500px;"></div>
    <p>{{message}}</p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/ui-lightness/jquery-ui-1.10.4.css" />
    <link rel="stylesheet" href="/Content/css/slick.grid.css" />
    <link rel="stylesheet" href="/Content/css/slick-default-theme.css" />
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
<script type="text/javascript" src="/Scripts/angular-1.2.6.min.js"></script>
<script type="text/javascript">
    function App($scope) {
        // put your angular-using code here.  Angular knows to call this because the function name matches the ng-controller attribute above
        $scope.message = "Hello from Angular";

        $(function() {
            var grid;
            var columns = [
                {id: "title", name: "Title", field: "title"},
                {id: "duration", name: "Duration", field: "duration"},
                {id: "%", name: "% Complete", field: "percentComplete"},
                {id: "start", name: "Start", field: "start"},
                {id: "finish", name: "Finish", field: "finish"},
                {id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
            ];

            var options = {
                enableCellNavigation: true,
                enableColumnReorder: false
            };

            var data = [];
            for (var i = 0; i < 500; i++) {
                data[i] = {
                    title: "Task " + i,
                    duration: "5 days",
                    percentComplete: Math.round(Math.random() * 100),
                    start: "01/01/2009",
                    finish: "01/05/2009",
                    effortDriven: (i % 5 == 0)
                };
            }

            grid = new Slick.Grid("#myGrid", data, columns, options);
        });
    }
</script>
</asp:Content>

