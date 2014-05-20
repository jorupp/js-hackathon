<%@ Page Language="C#" AutoEventWireup="true" %>

<asp:Content runat="server" ContentPlaceholderID="body">
    <table id="myGrid"></table>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="head">
    <link rel="stylesheet" href="/Content/css/ui-lightness/jquery-ui-1.10.4.css" />
    <link rel="stylesheet" href="/Content/css/ui.jqgrid.css" />
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
    <script type="text/javascript" src="/Scripts/jquery-ui-1.10.4.min.js"></script>
    <script type="text/javascript" src="/Scripts/jquery.jqGrid.min.js"></script>
    <script type="text/javascript">
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
    </script>
</asp:Content>
