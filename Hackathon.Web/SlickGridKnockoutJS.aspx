<%@ Page Language="C#" %>

<asp:Content runat="server" ContentPlaceholderID="body">
<div id="app">
    <p data-bind="text: message"></p>
</div>
</asp:Content>

<asp:Content runat="server" ContentPlaceholderID="scripts">
<script type="text/javascript" src="/Scripts/knockout-3.1.0.js"></script>
<script type="text/javascript">
    (function() {
        // put your knockout-using code here
        var model = { message: ko.observable("Hello from Knockout") };

        // this wires the model into the DOM    
        ko.applyBindings(model, $("#app")[0]);
    })();
</script>
</asp:Content>

