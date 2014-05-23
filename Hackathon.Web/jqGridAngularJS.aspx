<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div ng-app ng-controller="App" ng-cloak>
    <table id="myGrid"></table>
    <p>{{message}}</p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/ui-lightness/jquery-ui-1.10.4.css" />
    <link rel="stylesheet" href="/Content/css/ui.jqgrid.css" />
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/Scripts/angular-1.2.6.min.js"></script>
<script type="text/javascript">
    function App($scope) {
        // put your angular-using code here.  Angular knows to call this because the function name matches the ng-controller attribute above
        $scope.message = "Hello from Angular";
        $(function() {
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

            $("#myGrid").jqGrid({
                colNames: ['Title', 'Duration', '% Complete', 'Start', 'Finish', 'Effort Driven'],
                colModel: [
                    {name:'title', index: 'title'},
                    {name:'duration', index: 'duration'},
                    {name:'percentComplete', index: 'percentComplete'},
                    {name:'start', index: 'start'},
                    {name:'finish', index: 'finish'},
                    {name:'effortDriven', index: 'effortDriven'}
                ],
                data: data,
                datatype: 'local'
            });
        });
    }
</script>
</asp:Content>

