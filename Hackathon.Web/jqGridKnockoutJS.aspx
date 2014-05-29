<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div id="app">
    <table id="myGrid"></table>
    <p data-bind="text: message"></p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/ui-lightness/jquery-ui-1.10.4.css" />
    <link rel="stylesheet" href="/Content/css/ui.jqgrid.css" />
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/Scripts/i18n/grid.locale-en.js"></script>
<script type="text/javascript" src="/Scripts/knockout-3.1.0.js"></script>
<script type="text/javascript">
    (function() {
        // put your knockout-using code here
        var model = { message: ko.observable("Hello from Knockout") };

        // this wires the model into the DOM    
        ko.applyBindings(model, $("#app")[0]);

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
    })();
</script>
</asp:Content>

