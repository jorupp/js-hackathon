<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div ng-app ng-controller="App" ng-cloak>
    <div id="myGrid"></div>
    <p>{{message}}</p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/jqx/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="/Content/css/jqx/jqx.darkblue.css" type="text/css" />
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/jqx-all.js"></script>
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

            $("#myGrid").jqxGrid({
                source: new $.jqx.dataAdapter({ localdata: data, datatype: "local" }),
                columns: [
                    {text:'Title', datafield: 'title', width: 100},
                    {text:'Duration', datafield: 'duration', width: 100},
                    {text:'Percent Complete', datafield: 'percentComplete', width: 75},
                    {text:'Start', datafield: 'start', width: 110},
                    {text:'Finish', datafield: 'finish', width: 110},
                    {text:'Effort Driven', datafield: 'effortDriven', width: 80}
                ]
            });
        });
    }
</script>
</asp:Content>

