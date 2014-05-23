<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div id="app">
    <div id="myGrid"></div>
    <p data-bind="text: message"></p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/jqx/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="/Content/css/jqx/jqx.darkblue.css" type="text/css" />
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/jqx-all.js"></script>
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
    })();
</script>
</asp:Content>

